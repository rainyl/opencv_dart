#!/usr/bin/env python3
"""Determine shared libraries required by a program."""

# This file is necessary so that we can specify the entry point for pex.

import argparse
import json
import pathlib
import sys
from typing import Any, List, TextIO

import lddwrap
import pylddwrap_meta


class Args:
    """Represent parsed command-line arguments."""

    def __init__(
        self,
        format_: str,
        path: str,
        sort_by: str,
        recursive: bool,
        unused: bool,
    ) -> None:
        """Initialize with arguments parsed with ``argparse``."""
        self.format = format_
        self.path = pathlib.Path(path)
        self.sort_by = None if sort_by is None else sort_by
        self.recursive = recursive
        self.unused = unused


def parse_args(sys_argv: List[str]) -> Args:
    """Parse command-line arguments."""
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "-v",
        "--version",
        help="Display the version and return immediately",
        action="version",
        version=pylddwrap_meta.__version__ + "\n",
    )
    parser.add_argument(
        "-f",
        "--format",
        help="Specify the output format.",
        default="verbose",
        choices=["verbose", "json"],
    )
    parser.add_argument(
        "-s",
        "--sorted",
        # ``sorted`` is reserved for a built-in method, so we need to pick
        # a different identifier.
        dest="sort_by",
        help="If set, the output is sorted by the given attribute",
        const="soname",
        choices=lddwrap.DEPENDENCY_ATTRIBUTES,
        nargs="?",
    )
    parser.add_argument(
        "-R",
        "--recursive",
        dest="recursive",
        default=False,
        action="store_true",
        help="If set, recursively list all dependencies",
    )
    parser.add_argument(
        "--unused",
        dest="unused",
        default=False,
        action="store_true",
    )

    parser.add_argument("path", help="Specify path to the binary")

    _args = parser.parse_args(sys_argv[1:])

    if pathlib.Path(_args.path).is_dir():
        parser.error(
            "Path '{}' is a dir. Path to file required. Check out "
            "--help for more information.".format(_args.path)
        )

    if not pathlib.Path(_args.path).is_file():
        parser.error(
            "Path '{}' is not a file. Path to file required. Check out "
            "--help for more information.".format(_args.path)
        )

    return Args(
        format_=_args.format,
        path=_args.path,
        sort_by=_args.sort_by,
        recursive=_args.recursive,
        unused=_args.unused,
    )


def _main(args: Args, stream: TextIO) -> int:
    """Execute the main routine."""
    # pylint: disable=protected-access
    deps = lddwrap.list_dependencies(path=args.path, unused=args.unused)

    if args.sort_by is not None:
        lddwrap._sort_dependencies_in_place(deps=deps, sort_by=args.sort_by)

    if args.format == "verbose":
        lddwrap._output_verbose(deps=deps, stream=stream)
    elif args.format == "json":
        lddwrap._output_json(deps=deps, stream=stream)
    else:
        raise NotImplementedError("Unhandled format: {}".format(args.format))
    stream.write("\n")

    return 0


def parse_to_list(args: Args):
    deps = lddwrap.list_dependencies(path=args.path, unused=args.unused, recursive=args.recursive)
    if args.sort_by is not None:
        lddwrap._sort_dependencies_in_place(deps=deps, sort_by=args.sort_by)
    return [dep.as_mapping() for dep in deps]


def main() -> None:
    """Wrap the main routine so that it can be tested."""
    args = parse_args(sys_argv=sys.argv)
    sys.exit(_main(args=args, stream=sys.stdout))


if __name__ == "__main__":
    main()
