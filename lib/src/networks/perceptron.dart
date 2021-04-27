import 'package:synadart/src/activation.dart';
import 'package:synadart/src/network.dart';
import 'package:synadart/src/networks/learning/backpropagation.dart';

/// Simple perceptron network. One input layer, one output layer.
class Perceptron extends Network with Backpropagation {
  /// Takes [inputNeuronCount] and constructs a network using two layers;
  /// 'input' with [inputNeuronCount] neurons and 'output' with 1 neuron.
  Perceptron({
    required ActivationAlgorithm activationAlgorithm,
    required int inputNeuronCount,
  }) : super(
            activationAlgorithm: activationAlgorithm,
            layerSizes: [inputNeuronCount, 1]);
}
