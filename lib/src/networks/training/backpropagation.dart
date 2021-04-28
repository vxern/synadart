import 'package:synadart/src/networks/network.dart';
import 'package:synadart/src/utils/mathematical_operations.dart';

/// Mixin that allows networks to perform backpropagation
mixin Backpropagation on Network {
  /// Perform the `backpropagation` algorithm by comparing the observed with the expected
  /// values and propagate each layer using the 'errors' or the 'cost'
  void propagateBackwards(List<double> input, List<double> expected) {
    final observed = process(input);

    List<double> errors = subtract(expected, observed);

    for (int index = layers.length - 1; index > 0; index--) {
      errors = layers[index].propagate(errors);
    }
  }

  /// Train the network by passing in [input], their respective [expectedResults]
  /// as well as the number of iterations to make over these inputs
  void train({
    required List<List<double>> input,
    required List<List<double>> expected,
    required int iterations,
  }) {
    if (input.isEmpty || expected.isEmpty) {
      log.warning('[input] and [expected] fields must not be empty.');
      return;
    }

    if (input.length != expected.length) {
      log.warning('[input] and [expected] fields must be of the same length.');
      return;
    }

    if (iterations < 1) {
      log.warning(
          'You cannot train a network without granting it at least one iteration.');
      return;
    }

    print('Training network with $iterations iterations...');
    stopwatch.start();
    for (int iteration = 0; iteration < iterations; iteration++) {
      for (int index = 0; index < input.length; index++) {
        propagateBackwards(input[index], expected[index]);
      }
    }
    stopwatch.stop();
    print('Training complete in ${stopwatch.elapsedMilliseconds / 1000}s');
  }
}
