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
    required int parentNeuronCount,
    List<double> weights = const [],
    this.inputs = const [],
  }) {
    activation = resolveActivationAlgorithm(ActivationAlgorithm.ReLU);

    if (weights.isNotEmpty) {
      return;
    }

    if (parentNeuronCount == 0) {
      return;
    }

    final double limit = 1 / sqrt(parentNeuronCount);
    this.weights = ValueGenerator().generateListWithRandomDoubles(parentNeuronCount, from: -limit, to: limit);
  }

  /// If this neuron is an input neuron, it should output 
  /// its sole input that the layer accepts
  /// Otherwise, it should output the weighted sum of the
  /// inputs and weights passed through the activation function
  double get output => inputs.length == 0 ? inputs[0] : activation(() => dot(inputs, weights));
}