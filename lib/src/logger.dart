import 'package:ansicolor/ansicolor.dart';

enum Severity { debug, success, info, warning, error }

class Logger {
  final String name;

  const Logger(this.name);

  // Assigns a colour to a severity and outputs a message once formatted
  Future log(dynamic message, {Severity severity = Severity.info}) async {
    AnsiPen pen;

    switch (severity) {
      case Severity.debug:
        pen = AnsiPen()..gray();
        break;
      case Severity.success:
        pen = AnsiPen()..green();
        break;
      case Severity.info:
        pen = AnsiPen()..cyan();
        break;
      case Severity.warning:
        pen = AnsiPen()..yellow();
        break;
      case Severity.error:
        pen = AnsiPen()
          ..red()
          ..yellow();
        break;
    }

    message = pen(message.toString());
    
    print('[$name] ~ $message');
  }

  // Interfaces for the log command
  Future debug(dynamic message) async => log(message, severity: Severity.debug);
  Future success(dynamic message) async => log(message, severity: Severity.success);
  Future info(dynamic message) async => log(message, severity: Severity.info);
  Future warning(dynamic message) async => log(message, severity: Severity.warning);
  Future error(dynamic message) async => log(message, severity: Severity.error);
}