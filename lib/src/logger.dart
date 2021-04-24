import 'package:ansicolor/ansicolor.dart';

enum Severity { Debug, Success, Info, Warning, Error }

class Logger {
  final String name;

  const Logger(this.name);

  // Assigns a colour to a severity and outputs a message once formatted
  void log(dynamic message, {Severity severity = Severity.Info}) async {
    AnsiPen pen;

    switch (severity) {
      case Severity.Debug:
        pen = AnsiPen()..gray();
        break;
      case Severity.Success:
        pen = AnsiPen()..green();
        break;
      case Severity.Info:
        pen = AnsiPen()..cyan();
        break;
      case Severity.Warning:
        pen = AnsiPen()..yellow();
        break;
      case Severity.Error:
        pen = AnsiPen()
          ..red()
          ..yellow();
        break;
    }

    message = pen(message.toString());
    
    print('[$name] ~ $message');
  }

  // Interfaces for the log command
  void debug(dynamic message) async => log(message, severity: Severity.Debug);
  void success(dynamic message) async => log(message, severity: Severity.Success);
  void info(dynamic message) async => log(message, severity: Severity.Info);
  void warning(dynamic message) async => log(message, severity: Severity.Warning);
  void error(dynamic message) async => log(message, severity: Severity.Error);
}