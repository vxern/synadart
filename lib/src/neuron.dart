import 'dart:math';

import 'package:neural_network/src/activation.dart';
import 'package:neural_network/src/utils/mathematical_operations.dart';
import 'package:neural_network/src/utils/value_generator.dart';

class Neuron {
  late final ActivationFunction activation;

  late final List<double> inputs;
  late final List<double> weights;

  Neuron({
    required ActivationAlgorithm activationAlgorithm,
    required int connections,
    List<double> weights = const [],
    this.inputs = const [],
  }) {
    activation = resolveActivationAlgorithm(ActivationAlgorithm.ReLU);

    if (weights.isEmpty) {
      final double limit = 1 / sqrt(connections);
      this.weights = ValueGenerator().generateListWithRandomDoubles(connections, from: -limit, to: limit);
    }
  }

  /// Get the output of this neuron by taking the weighted sum
  /// and passing it through the activator function
  double get output => activation(() => dot(inputs, weights));
}