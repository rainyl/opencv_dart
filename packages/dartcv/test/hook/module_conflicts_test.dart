import 'package:dartcv4/src/hook_helpers/module_conflicts.dart';
import 'package:test/test.dart';

void main() {
  group('transitiveModuleDependencies', () {
    test('ximgproc pulls in calib3d, features2d and flann transitively', () {
      final deps = transitiveModuleDependencies('ximgproc');
      expect(deps, containsAll({'imgproc', 'calib3d', 'features2d', 'flann', 'imgcodecs', 'video'}));
    });

    test('xobjdetect pulls in calib3d transitively via objdetect', () {
      final deps = transitiveModuleDependencies('xobjdetect');
      expect(deps, containsAll({'imgproc', 'objdetect', 'imgcodecs', 'calib3d', 'features2d', 'flann'}));
    });
  });

  group('validateModuleConflicts', () {
    test('omitted dependencies are allowed (CMake closure auto-enables them)', () {
      validateModuleConflicts(
        modules: const {'ximgproc'},
        explicitlyExcluded: const {},
      );
    });

    test('rejects ximgproc when calib3d is explicitly excluded', () {
      expect(
        () => validateModuleConflicts(
          modules: const {'ximgproc'},
          explicitlyExcluded: const {'calib3d'},
        ),
        throwsArgumentError,
      );
    });

    test('rejects transitive conflict: objdetect with features2d excluded', () {
      expect(
        () => validateModuleConflicts(
          modules: const {'objdetect'},
          explicitlyExcluded: const {'features2d'},
        ),
        throwsArgumentError,
      );
    });

    test('rejects features2d when flann is explicitly excluded', () {
      expect(
        () => validateModuleConflicts(
          modules: const {'features2d'},
          explicitlyExcluded: const {'flann'},
        ),
        throwsArgumentError,
      );
    });

    test('reports all conflicts in a single error', () {
      expect(
        () => validateModuleConflicts(
          modules: const {'ximgproc', 'videoio'},
          explicitlyExcluded: const {'calib3d', 'imgcodecs'},
        ),
        throwsA(
          isA<ArgumentError>().having(
            (e) => e.message,
            'message',
            allOf(
              contains("'ximgproc' requires 'calib3d'"),
              contains("'ximgproc' requires 'imgcodecs'"),
              contains("'videoio' requires 'imgcodecs'"),
            ),
          ),
        ),
      );
    });

    test('allows highgui when optional imgcodecs/videoio are excluded', () {
      validateModuleConflicts(
        modules: const {'highgui'},
        explicitlyExcluded: const {'imgcodecs', 'videoio'},
      );
    });
  });
}
