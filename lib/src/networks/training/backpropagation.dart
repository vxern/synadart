import 'package:synadart/src/networks/network.dart';
import 'package:synadart/src/utils/mathematical_operations.dart';

/// Extension to `Network` that allows it to train by performing
/// backpropagation.
mixin Backpropagation on Network {
  /// Performs the backpropagation algorithm by comparing the observed values
  /// with the expected values, and propagates each layer using the knowledge of
  /// the network's 'cost', which indicates how bad the network is performing.
  void propagateBackwards(List<double> input, List<double> expected) {
    final observed = process(input);

    var errors = subtract(expected, observed);

    for (var index = layers.length - 1; index > 0; index--) {
      errors = layers[index].propagate(errors);
    }
  }

  /// Trains the network using the passed [inputs], their respective [expected]
  /// results, as well as the number of iterations to make during training.
  ///
  /// [inputs] - The values we pass into the `Network`.
  ///
  /// [expected] - What we expect the `Network` to output.
  ///
  /// [iterations] - How many times the `Network` should perform backpropagation
  /// using the provided inputs and expected values.
  ///
  /// ⚠️ Throws a [FormatException] if the:
  /// - The [inputs] and [expected] vectors are empty.
  /// - The [inputs] and [expected] vectors are of different sizes.
  /// - The number of iterations is less than 1.
  void train({
    required List<List<double>> inputs,
    required List<List<double>> expected,
    required int iterations,
    @Deprecated(
      'The package no longer logs messages, thus the quiet mode no longer '
      'serves a purpose.',
    )
    bool quiet = false,
  }) {
    if (inputs.isEmpty || expected.isEmpty) {
      throw const FormatException(
        'Both inputs and expected results must not be empty.',
      );
    }

    if (inputs.length != expected.length) {
      throw const FormatException(
        'Inputs and expected result lists must be of the same length.',
      );
    }

    if (iterations < 1) {
      throw const FormatException(
        'You cannot train a network without granting it at least one '
        'iteration.',
      );
    }

    for (var iteration = 0; iteration < iterations; iteration++) {
      for (var index = 0; index < inputs.length; index++) {
        propagateBackwards(inputs[index], expected[index]);
      }
    }
  }
}
