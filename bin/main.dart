import 'dart:io';
import 'package:args/args.dart';
import 'package:bloc_code_generator/bloc_code_generator.dart' as generator;
import "package:path/path.dart" show dirname;

main(List<String> arguments) {
  bool foundCommentSwitch = false;
  final ArgParser argParser = ArgParser()
    ..addOption('name',
        defaultsTo: 'CounterBloc', help: "name of your Bloc file")
    ..addOption('path', defaultsTo: '', help: "path to save your Bloc file")
    ..addFlag('comments',
        defaultsTo: true, help: "Do you want to include comments?")
    ..addFlag('help',
        abbr: 'h', negatable: false, help: "Displays this help information.");
  final argResults = argParser.parse(arguments);
  String blocName = argResults['name'];
  String path = argResults['path'];
  foundCommentSwitch = argResults['comments'];

  if (blocName == null) {
    generator.handleError("name is missing!");
  }
  if (path == null) {
    generator.handleError("path is missing!");
  }
  if (argResults['help']) {
    print("""
** HELP **
${argParser.usage}
    """);
    exit(2);
  }

  final fileName =
      '${blocName.substring(0, 1).toLowerCase() + blocName.substring(1)}.dart';
  final savingPath = path.isEmpty ? "$fileName" : "$path\\$fileName";
  String readingPath;
  var current = dirname(Platform.script.toFilePath().toString()).substring(
      0, dirname(Platform.script.toFilePath().toString()).length - 3);

  if (foundCommentSwitch) {
    readingPath = current + "samples\\sample_code.txt";
  } else if (!foundCommentSwitch) {
    readingPath = current + "samples\\sample_code_no_comment.txt";
  }
  File(readingPath).readAsString().then((String contents) {
    try {
      File(savingPath)
          .writeAsString(generator.generateBoilerPlateCode(blocName, contents))
          .then((File file) {
        String postString =
            foundCommentSwitch ? "with comments" : "without comments";
        print("Generated file $fileName at ${file.absolute} $postString");
      });
    } catch (e) {
      generator.handleError(e.toString());
    }
  });
}
