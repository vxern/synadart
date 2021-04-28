import 'dart:math';

/// Class with static functions that allow for generating random values between maxima
class ValueGenerator {
  static final Random random = Random.secure();

  /// Generates a single `double` inside the range [from] (inclusive) - [to] (exclusive)
  static double nextDouble({double from = 0, double to = 0}) => random.nextDouble() * (to - from) + from;

  /// Generator function for `double`s inside the range [from] (inclusive) - [to] (exclusive)
  static Iterable<double> doubleIterableSync({double from = 0, double to = 0}) sync* {
    while (true) {
      yield nextDouble(from: from, to: to);
    }
  }

  /// Generates a list of size [size], filled with random `double`s
  static List<double> generateListWithRandomDoubles({required int size, double from = 0, double to = 0}) {
    return doubleIterableSync(from: from, to: to).take(size).toList();
  }
}
