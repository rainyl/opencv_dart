import 'package:args/command_runner.dart';

import 'setup_commands.dart';

void main(List<String> args) async {
  final cmd = CommandRunner("setup", "Setup for opencv_dart")
    ..addCommand(WindowsSetupCommand())
    ..addCommand(LinuxSetupCommand())
    ..addCommand(MacOsSetupCommand())
    ..addCommand(AndroidSetupCommand())
    ..addCommand(IosSetupCommand());
  await cmd.run(args);
}
