import 'package:ansicolor/ansicolor.dart';

enum Severity { debug, success, info, warning, error }

/// Logger class that allows simple logging of messages, including the origin of the message.
class Logger {
  /// Name of the origin of messages, for example the `Network` class will have messaged displayed
  /// with a `Network` prefix.
  final String name;

  const Logger(this.name);

  /// Assigns a colour to the severity of the message and outputs a coloured message once formatted
  Future log(dynamic message, {Severity severity = Severity.info}) async {
    final AnsiPen pen;

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
        pen = AnsiPen()..red()..yellow();
        break;
    }

    message = pen(message.toString());

    print('[$name] ~ $message');
  }

  /// Prints a debug message
  Future debug(dynamic message) async => log(message, severity: Severity.debug);
  /// Prints a success message
  Future success(dynamic message) async => log(message, severity: Severity.success);
  /// Prints an informational message
  Future info(dynamic message) async => log(message, severity: Severity.info);
  /// Prints a warning message
  Future warning(dynamic message) async => log(message, severity: Severity.warning);
  /// Prints an error message
  Future error(dynamic message) async => log(message, severity: Severity.error);
}
