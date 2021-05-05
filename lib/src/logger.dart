import 'package:ansicolor/ansicolor.dart';

enum Severity { debug, success, info, warning, error }

/// Logger class that allows simple logging of messages, including the origin of the message.
class Logger {
  /// Name of the origin of messages, for example the `Network` class will have messaged displayed
  /// with a `Network` prefix.
  final String name;

  /// Construct logger with a name of its owner
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

    message = message.toString().replaceAll('\n', '\n' + ' ' * (3 + name.length));
    message = pen(message.toString());

    print('[$name] $message');
  }

  /// Converts seconds to an Estimated Time of Arrival string
  String secondsToETA(int seconds) {
    String eta = '';

    // Break down the total number of seconds into larger units of time
    int hours = seconds ~/ (60 * 60);
    seconds -= hours * (60 * 60);
    int minutes = seconds ~/ 60;
    seconds -= minutes * 60;

    // Append a zero to single-digit time representations
    if (hours < 10) {
      eta += '0';
    }
    eta += '$hours:';

    if (minutes < 10) {
      eta += '0';
    }
    eta += '$minutes:';
    
    if (seconds < 10) {
      eta += '0';
    }
    eta += '$seconds';

    return eta;
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
