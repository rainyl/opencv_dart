$ENV:PATH = "$pwd/windows;$ENV:PATH"

dart pub global run coverage:test_with_coverage .\test\calib3d_test.dart

dart pub global run coverage:format_coverage `
    --packages=.dart_tool/package_config.json `
    --lcov -i coverage/coverage.json `
    -o coverage/lcov.info
