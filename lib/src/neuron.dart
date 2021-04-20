import 'dart:math';

import 'package:neural_network/src/activation.dart';
import 'package:neural_network/src/utils/mathematical_operations.dart';
import 'package:neural_network/src/utils/value_generator.dart';

/// Representation of a single `node` in a network that can have several forms and functions. 
/// The most basic function of the neuron is to take inputs and transform them into a single output.
class Neuron {
  late final ActivationFunction activation;
  final List<double> weights;

  final List<double> inputs = [];

  /// [activationAlgorithm] - The algorithm that should be used as the activation function
  /// [parentNeuronCount] - How many neurons from the previous layer this neuron is connected to
  /// [weights] - Weights of the connections with neurons from the previous layer
  Neuron({required ActivationAlgorithm activationAlgorithm, required int parentNeuronCount, this.weights = const []}) {
    assert(parentNeuronCount >= 0, '`parentNeuronCount` must not be negative');
    
    activation = resolveActivationAlgorithm(activationAlgorithm);

    if (weights.isNotEmpty || parentNeuronCount == 0) {
      return;
    }

    // Generate random values for the weights of connections
    final double limit = 1 / sqrt(parentNeuronCount);
    this.weights.addAll(ValueGenerator.generateListWithRandomDoubles(parentNeuronCount, from: -limit, to: limit));
  }

  /// If the neuron does not have weights, meaning it is not connected, it will only accept one input.
  /// Otherwise, accept all inputs
  void accept({List<double>? inputs, double? input}) {
    if (weights.isNotEmpty) {
      assert(inputs != null, 'Expected multiple inputs but received none');
      this.inputs.addAll(inputs!);
      return;
    }

    assert(input != null, 'Expected a single input but received none');
    this.inputs[0] = input!;
  }

  /// If this neuron is an input neuron, it should output its sole input that the layer accepts.
  /// Otherwise, it should output the weighted sum of the inputs and weights passed through the activation function.
  double get output {
    assert(inputs.isNotEmpty, 'This neuron has not been supplied with any inputs, thus it cannot produce an output');

    return weights.length == 0 ? inputs[0] : activation(() => dot(inputs, weights));
  }
}