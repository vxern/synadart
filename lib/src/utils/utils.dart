/// Converts seconds to an estimated time of arrival (ETA) string.
String secondsToETA(int seconds) {
  var eta = '';

  // Compose the total number of seconds into larger units of time.
  var secondsSink = seconds;
  final hours = seconds ~/ (60 * 60);
  secondsSink -= hours * (60 * 60);
  final minutes = seconds ~/ 60;
  secondsSink -= minutes * 60;

  // Append a zero to single-digit time representations.
  if (hours < 10) {
    eta += '0';
  }
  eta += '$hours:';

  if (minutes < 10) {
    eta += '0';
  }
  eta += '$minutes:';

  if (secondsSink < 10) {
    eta += '0';
  }

  return eta += '$secondsSink';
}
