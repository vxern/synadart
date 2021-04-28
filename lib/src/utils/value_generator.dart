import 'dart:math';

class ValueGenerator {
  static final Random random = Random.secure();

  /// Generates a `double` in the range [from] (inclusive) - [to] (exclusive)
  static double nextDouble({double from = 0, double to = 0}) =>
      random.nextDouble() * (to - from) + from;

  static Iterable<double> doubleIterableSync(
      {double from = 0, double to = 0}) sync* {
    while (true) {
      yield nextDouble(from: from, to: to);
    }
  }

  /// Generates a list of size [size], filled with random double values
  static List<double> generateListWithRandomDoubles({required int size, double from = 0, double to = 0}) {
    return doubleIterableSync(from: from, to: to).take(size).toList();
  }
}
