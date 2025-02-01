import 'dart:io';

import 'package:args/args.dart';
import 'package:dartcv4/dartcv.dart' as cv;

const String version = '0.0.1';

ArgParser buildParser() {
  return ArgParser()
    ..addFlag(
      'help',
      abbr: 'h',
      negatable: false,
      help: 'Print this usage information.',
    )
    ..addOption(
      'image',
      abbr: "i",
      defaultsTo: "images/lenna.png",
      help: "The image path.",
    )
    ..addFlag(
      'verbose',
      abbr: 'v',
      negatable: false,
      help: 'Show additional command output.',
    )
    ..addFlag(
      'version',
      negatable: false,
      help: 'Print the tool version.',
    );
}

void printUsage(ArgParser argParser) {
  print('Usage: dart dart_cli.dart <flags> [arguments]');
  print(argParser.usage);
}

void main(List<String> arguments) {
  final ArgParser argParser = buildParser();
  try {
    final ArgResults results = argParser.parse(arguments);

    // Process the parsed arguments.
    if (results.wasParsed('help')) {
      printUsage(argParser);
      return;
    }
    if (results.wasParsed('version')) {
      print('dart_cli version: $version');
      return;
    }

    final imagePath = results['image'] as String;
    if (File(imagePath).existsSync()) {
      showImage(imagePath);
      return;
    } else {
      throw PathNotFoundException(imagePath, OSError("File not found"));
    }
  } on FormatException catch (e) {
    // Print usage information if an invalid argument was provided.
    print(e.message);
    print('');
    printUsage(argParser);
  }
}

void showImage(String path) {
  final mat = cv.imread(path);
  print(mat);
  // final win = cv.Window(path);
  // win.imshow(mat);
  // final gray = cv.cvtColor(mat, cv.COLOR_BGR2GRAY);
  // win.waitKey(3000);
  // win.imshow(gray);
  // win.waitKey(0);
}
