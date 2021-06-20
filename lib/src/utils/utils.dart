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
