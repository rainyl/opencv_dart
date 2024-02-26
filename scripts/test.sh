#!/bin/bash

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:"`pwd`/linux"

dart test test/

# dart pub global run coverage:test_with_coverage

# dart pub global run coverage:format_coverage --packages=.dart_tool/package_config.json --lcov -i coverage/coverage.json -o coverage/lcov.info
