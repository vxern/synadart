import 'dart:math';

final Random _random = Random.secure();

/// Generates a single `double` inside the range [from] (inclusive) - [to]
/// (exclusive).
double nextDouble({double from = 0, double to = 0}) =>
    _random.nextDouble() * (to - from) + from;

/// Generator function for `double`s inside the range [from] (inclusive) - [to]
/// (exclusive).
Iterable<double> doubleIterableSync({double from = 0, double to = 0}) sync* {
  while (true) {
    yield nextDouble(from: from, to: to);
  }
}

/// Generates a list of size [size], filled with random `double` values.
List<double> generateListWithRandomDoubles(
        {required int size, double from = 0, double to = 0}) =>
    doubleIterableSync(from: from, to: to).take(size).toList();
