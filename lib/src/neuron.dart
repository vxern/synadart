import 'dart:math';

import 'package:synadart/src/activation.dart';
import 'package:synadart/src/utils/mathematical_operations.dart';
import 'package:synadart/src/utils/value_generator.dart';

/// Representation of a single `node` in a network that can have several forms and functions. 
/// The most basic function of the neuron is to take inputs and transform them into a single output.
class Neuron {
  late final ActivationFunction activation;
  late final ActivationFunction activationPrime; // The derivative of the activation function
  double learningRate = 0.1; // TODO: Remove hard-coded learning rate

  List<double> weights = [];
  List<double> inputs = [];

  /// [activationAlgorithm] - The algorithm that should be used as the activation function
  /// [parentNeuronCount] - How many neurons from the previous layer this neuron is connected to
  /// [weights] - Weights of the connections with neurons from the previous layer
  Neuron({required ActivationAlgorithm activationAlgorithm, required int parentNeuronCount, List<double> weights = const []}) {
    assert(parentNeuronCount >= 0, '`parentNeuronCount` must not be negative');
    
    activation = resolveActivationAlgorithm(activationAlgorithm);
    activationPrime = resolveDerivative(activationAlgorithm);

    if (weights.isNotEmpty || parentNeuronCount == 0) {
      this.weights = weights;
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
      this.inputs = inputs!;
      return;
    }

    assert(input != null, 'Expected a single input but received none');
    this.inputs.insert(0, input!);
  }
  
  /// Adjust this `Neuron`'s weights and return their adjusted values
  List<double> adjust({required double weightMargin}) {
    final List<double> adjustedWeights = [];

    for (int index = 0; index < weights.length; index++) {
      adjustedWeights.add(weightMargin * weights[index]);
      print('Current weight: ${weights[index]}');
      weights[index] -= 
        learningRate * 
        -weightMargin * // TODO: Shouldn't this be δC/δa?
        activationPrime(() => dot(inputs, weights)) * // δa/δz
        inputs[index]; // δz/δw
    }

    return adjustedWeights;
  }

  /// If this neuron is an input neuron, it should output its sole input that the layer accepts.
  /// Otherwise, it should output the weighted sum of the inputs and weights passed through the activation function.
  double get output {
    assert(inputs.isNotEmpty, 'This neuron has not been supplied with any inputs, thus it cannot produce an output');

    return weights.length == 0 ? inputs[0] : activation(() => dot(inputs, weights));
  }
}