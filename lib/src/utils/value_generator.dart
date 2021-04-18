import 'dart:math';

class ValueGenerator {
  final Random random = Random.secure();

  /// Generates a `double` in the range [from] (inclusive) - [to] (exclusive)
  double nextDouble({double from = 0, double to = 0}) => random.nextDouble() * (to - from) + from;

  Iterable<double> doubleIterableSync({double from = 0, double to = 0}) sync* {
    while (true) {
      yield nextDouble(from: from, to: to);
    }
  }

  /// Generates a list of size [size], filled with random double values
  List<double> generateListWithRandomDoubles(int size, {double from = 0, double to = 0}) {
    return [...doubleIterableSync(from: from, to: to).take(size)];
  }
}