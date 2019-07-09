import 'dart:io';

String generateBoilerPlateCode(String blocName, String sampleCode) {
  return sampleCode.replaceAll(RegExp(r'blocName'), blocName);
}

void handleError(String msg) {
  stderr.writeln(msg);
  exit(2);
}
