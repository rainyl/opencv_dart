import 'dart:io';

import 'package:code_assets/code_assets.dart';
import 'package:dartcv4/src/hook_helpers/user_defines.dart';
import 'package:native_toolchain_cmake/native_toolchain_cmake.dart';
import 'package:test/test.dart';

/// Matches an [ArgumentError] naming [key] (i.e. `user_defines.<key>`).
Matcher throwsUserDefineError(String key) =>
    throwsA(isA<ArgumentError>().having((e) => e.name, 'name', 'user_defines.$key'));

void main() {
  group('defaults', () {
    test('parses an empty map', () {
      final args = UserDefineArgsParser.fromMap(const {}, targetOS: OS.linux);

      expect(args.skipBuild, isFalse);
      expect(args.debug, isFalse);
      expect(args.treeshake, isFalse);
      expect(args.parallelJobs, Platform.numberOfProcessors);
      expect(args.opencvVersion, isNull);
      expect(args.opencvDir, isNull);
      expect(args.useOpenCL, isFalse);
      expect(args.generator, Generator.make);
      expect(args.appleDeploymentTarget, isNull);
      expect(args.includeModules, isEmpty);
      expect(args.excludeModules, isEmpty);
      expect(args.modules, defaultIncludedModules);
      expect(args.platformDefines[OS.linux], isEmpty);
    });

    test('parses every option', () {
      final args = UserDefineArgsParser.fromMap(const {
        'skip_build': false,
        'debug': true,
        'treeshake': true,
        'parallel_jobs': 4,
        'opencv_version': '4.12.0',
        'opencv_dir': '/opt/opencv/lib/cmake/opencv4',
        'include_modules': ['imgcodecs', 'imgproc', 'dnn'],
        'exclude_modules': ['dnn'],
      }, targetOS: OS.linux);

      expect(args.skipBuild, isFalse);
      expect(args.debug, isTrue);
      expect(args.treeshake, isTrue);
      expect(args.parallelJobs, 4);
      expect(args.opencvVersion, '4.12.0');
      expect(args.opencvDir, '/opt/opencv/lib/cmake/opencv4');
      expect(args.appleDeploymentTarget, isNull); // not an Apple target
      expect(args.includeModules, ['imgcodecs', 'imgproc', 'dnn']);
      expect(args.excludeModules, ['dnn']);
      expect(args.modules, {'imgcodecs', 'imgproc'});
    });

    test('ignores unknown keys', () {
      // `cmake_version` is read by native_toolchain_cmake from the same map.
      final args = UserDefineArgsParser.fromMap(const {
        'cmake_version': '3.31.0',
        'ninja_version': 1.12,
      }, targetOS: OS.linux);

      expect(args.modules, defaultIncludedModules);
    });
  });

  group('modules', () {
    test('include_modules replaces the default set', () {
      final args = UserDefineArgsParser.fromMap(const {
        'include_modules': ['dnn'],
      }, targetOS: OS.linux);

      expect(args.modules, {'dnn'});
    });

    test('exclude_modules removes from the default set', () {
      final args = UserDefineArgsParser.fromMap(const {
        'exclude_modules': ['imgcodecs'],
      }, targetOS: OS.linux);

      expect(args.modules, {'imgproc'});
    });

    test('exclude_modules is applied after include_modules', () {
      final args = UserDefineArgsParser.fromMap(const {
        'include_modules': ['imgcodecs', 'imgproc', 'dnn', 'videoio'],
        'exclude_modules': ['dnn', 'videoio'],
      }, targetOS: OS.linux);

      expect(args.modules, {'imgcodecs', 'imgproc'});
    });

    test('baseModules is used when include_modules is not set', () {
      final args = UserDefineArgsParser.fromMap(
        const {
          'exclude_modules': ['imgcodecs'],
        },
        targetOS: OS.linux,
        baseModules: {'imgcodecs', 'dnn'},
      );

      expect(args.modules, {'dnn'});
    });

    test('duplicate names are dropped', () {
      final args = UserDefineArgsParser.fromMap(const {
        'include_modules': ['imgproc', 'imgproc'],
      }, targetOS: OS.linux);

      expect(args.includeModules, ['imgproc']);
    });

    test('rejects an unknown module', () {
      expect(
        () => UserDefineArgsParser.fromMap(const {
          'include_modules': ['imgproc', 'contrib'],
        }, targetOS: OS.linux),
        throwsA(
          isA<ArgumentError>().having(
            (e) => e.message,
            'message',
            allOf(contains('"contrib"'), contains('imgproc')),
          ),
        ),
      );
    });

    test('rejects `core`, which is always built', () {
      expect(
        () => UserDefineArgsParser.fromMap(const {
          'exclude_modules': ['core'],
        }, targetOS: OS.linux),
        throwsA(
          isA<ArgumentError>().having(
            (e) => e.message,
            'message',
            allOf(contains('"core"'), contains('always built')),
          ),
        ),
      );
    });

    test('rejects conflicting modules', () {
      expect(
        () => UserDefineArgsParser.fromMap(const {
          'include_modules': ['ximgproc'],
          'exclude_modules': ['calib3d'],
        }, targetOS: OS.linux),
        throwsArgumentError,
      );
    });
  });

  group('types', () {
    test('rejects a non-bool bool option', () {
      expect(
        () => UserDefineArgsParser.fromMap(const {'debug': 'yes'}, targetOS: OS.linux),
        throwsUserDefineError('debug'),
      );
    });

    test('rejects a non-int parallel_jobs', () {
      expect(
        () => UserDefineArgsParser.fromMap(const {'parallel_jobs': '4'}, targetOS: OS.linux),
        throwsUserDefineError('parallel_jobs'),
      );
    });

    test('rejects an unquoted version, with a hint to quote it', () {
      expect(
        () => UserDefineArgsParser.fromMap(const {'opencv_version': 4.12}, targetOS: OS.linux),
        throwsA(
          isA<ArgumentError>().having(
            (e) => e.message,
            'message',
            contains('quote the value in pubspec.yaml'),
          ),
        ),
      );
    });

    test('rejects a non-list module list', () {
      expect(
        () => UserDefineArgsParser.fromMap(const {'include_modules': 'imgproc'}, targetOS: OS.linux),
        throwsUserDefineError('include_modules'),
      );
    });

    test('rejects a non-string module name', () {
      expect(
        () => UserDefineArgsParser.fromMap(const {
          'include_modules': [1],
        }, targetOS: OS.linux),
        throwsUserDefineError('include_modules[0]'),
      );
    });

    test('rejects a non-map platform entry', () {
      expect(
        () => UserDefineArgsParser.fromMap(const {'windows': 'Ninja'}, targetOS: OS.linux),
        throwsUserDefineError('windows'),
      );
    });
  });

  group('per platform options', () {
    const defines = {
      'opencv_dir': '/top-level/opencv',
      'linux': {'opencv_dir': '/linux/opencv', 'use_opencl': true, 'generator': 'Ninja'},
      'android': {'opencv_dir': '/android/opencv'},
    };

    test('reads the options of the target OS', () {
      final args = UserDefineArgsParser.fromMap(defines, targetOS: OS.linux);

      expect(args.opencvDir, '/linux/opencv');
      expect(args.useOpenCL, isTrue);
      expect(args.generator, Generator.ninja);
    });

    test('falls back to the top-level opencv_dir', () {
      final args = UserDefineArgsParser.fromMap(defines, targetOS: OS.macOS);

      expect(args.opencvDir, '/top-level/opencv');
      expect(args.useOpenCL, isFalse);
      expect(args.generator, Generator.xcode);
    });

    test('does not read another OS sub-map', () {
      final args = UserDefineArgsParser.fromMap(defines, targetOS: OS.android);

      expect(args.opencvDir, '/android/opencv');
      expect(args.useOpenCL, isFalse);
    });

    test('exposes every platform sub-map', () {
      final args = UserDefineArgsParser.fromMap(defines, targetOS: OS.android);

      expect(args.platformDefines[OS.linux], defines['linux']);
      expect(args.platformDefines[OS.iOS], isEmpty);
    });

    test('without a target OS only top-level options apply', () {
      final args = UserDefineArgsParser.fromMap(defines);

      expect(args.opencvDir, '/top-level/opencv');
      expect(args.useOpenCL, isFalse);
      expect(args.generator, _hostDefaultGenerator);
      expect(args.modules, defaultIncludedModules);
    });

    test('OpenCL is always disabled on iOS', () {
      final args = UserDefineArgsParser.fromMap(const {
        'ios': {'use_opencl': true},
      }, targetOS: OS.iOS);

      expect(args.useOpenCL, isFalse);
    });
  });

  group('apple deployment target', () {
    test('parses the target OS value', () {
      expect(
        UserDefineArgsParser.fromMap(const {
          'ios': {'deployment_target': '15.0'},
        }, targetOS: OS.iOS).appleDeploymentTarget,
        '15.0',
      );
    });

    test('accepts a number, which YAML parses `15.0` as', () {
      expect(
        UserDefineArgsParser.fromMap(const {
          'ios': {'deployment_target': 15.0},
        }, targetOS: OS.iOS).appleDeploymentTarget,
        '15.0',
      );
    });

    test('does not read another OS sub-map', () {
      expect(
        UserDefineArgsParser.fromMap(const {
          'macos': {'deployment_target': '10.15'},
        }, targetOS: OS.iOS).appleDeploymentTarget,
        isNull,
      );
    });

    test('is empty when not set', () {
      expect(UserDefineArgsParser.fromMap(const {}, targetOS: OS.macOS).appleDeploymentTarget, isNull);
      expect(UserDefineArgsParser.fromMap(const {}, targetOS: OS.iOS).appleDeploymentTarget, isNull);
    });

    test('is empty for a non-Apple target OS', () {
      final args = UserDefineArgsParser.fromMap(const {
        'linux': {'deployment_target': '15.0'},
        'deployment_target': '15.0',
      }, targetOS: OS.linux);

      expect(args.appleDeploymentTarget, isNull);
    });

    test('rejects a non-version value', () {
      expect(
        () => UserDefineArgsParser.fromMap(const {
          'macos': {'deployment_target': true},
        }, targetOS: OS.macOS),
        throwsUserDefineError('deployment_target'),
      );
    });
  });

  group('generator', () {
    test('does not read a top-level generator', () {
      // `generator` is per-OS: a top-level one is neither used nor validated.
      final args = UserDefineArgsParser.fromMap(const {'generator': 'nonsense'});

      expect(args.generator, _hostDefaultGenerator);
    });

    test('maps every supported generator name', () {
      const names = {
        'Ninja': Generator.ninja,
        'Unix Makefiles': Generator.make,
        'Xcode': Generator.xcode,
        'Visual Studio 16 2019': Generator.vs2019,
        'Visual Studio 17 2022': Generator.vs2022,
        'Visual Studio 18 2026': Generator.vs2026,
      };

      for (final MapEntry(key: name, value: generator) in names.entries) {
        final args = UserDefineArgsParser.fromMap({
          'linux': {'generator': name},
        }, targetOS: OS.linux);

        expect(args.generator, generator, reason: name);
      }
    });

    test('rejects an unsupported generator', () {
      expect(
        () => UserDefineArgsParser.fromMap(const {
          'linux': {'generator': 'ninja'},
        }, targetOS: OS.linux),
        throwsA(
          isA<ArgumentError>()
              .having((e) => e.name, 'name', 'user_defines.linux.generator')
              .having((e) => e.message, 'message', contains('Ninja')),
        ),
      );
    });
  });
}

/// The default generator of the platform the tests run on.
final Generator _hostDefaultGenerator = switch (OS.current) {
  OS.linux => Generator.make,
  OS.macOS || OS.iOS => Generator.xcode,
  OS.windows => Generator.defaultGenerator,
  OS.android => Generator.ninja,
  _ => throw StateError('unsupported host OS: ${OS.current}'),
};
