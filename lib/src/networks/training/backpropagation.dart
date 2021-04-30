import 'dart:io';

import 'package:synadart/src/networks/network.dart';
import 'package:synadart/src/utils/mathematical_operations.dart';

/// Extension to `Network` that allows it to train by performing backpropagation
mixin Backpropagation on Network {
  /// Perform the backpropagation algorithm by comparing the observed with the expected
  /// values, and propagate each layer using the knowledge of the network's `cost`, which
  /// indicates how bad the network is performing.
  void propagateBackwards(List<double> input, List<double> expected) {
    final observed = process(input);

    List<double> errors = subtract(expected, observed);

    for (int index = layers.length - 1; index > 0; index--) {
      errors = layers[index].propagate(errors);
    }
  }

  /// Train the network by passing in [inputs], their respective [expected] results
  /// as well as the number of iterations to make during training
  void train({
    required List<List<double>> inputs,
    required List<List<double>> expected,
    required int iterations,
  }) {
    if (inputs.isEmpty || expected.isEmpty) {
      log.error('Both inputs and expected results must not be empty.');
      exit(0);
    }

    if (inputs.length != expected.length) {
      log.error('Inputs and expected result lists must be of the same length.');
      return;
    }

    if (iterations < 1) {
      log.error('You cannot train a network without granting it at least one iteration.');
      return;
    }

    for (int iteration = 0; iteration < iterations; iteration++) {
      stopwatch.start();
      for (int index = 0; index < inputs.length; index++) {
        propagateBackwards(inputs[index], expected[index]);
      }
      stopwatch.stop();
      if (iteration % 500 == 0) {
        log.info('Iterations: $iteration/$iterations ~ ETA: ${log.secondsToETA((stopwatch.elapsedMicroseconds * (iterations - iteration)) ~/ 1000000)}');
      }
      stopwatch.reset();
    }
  }
}
