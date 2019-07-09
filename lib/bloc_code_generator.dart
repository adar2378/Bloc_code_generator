import 'dart:io';

String generateBoilerPlateCode(String blocName, String sampleCode) {
  return sampleCode.replaceAll(RegExp(r'blocName'),
      blocName.substring(0, 1).toUpperCase() + blocName.substring(1));
}

void handleError(String msg) {
  stderr.writeln(msg);
  exit(2);
}
