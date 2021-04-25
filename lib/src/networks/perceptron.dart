import 'package:synadart/src/activation.dart';
import 'package:synadart/src/network.dart';

/// Simple perceptron network. One input layer, one output layer.
class Perceptron extends Network {
  /// Takes [inputNeuronCount] and constructs a network using two layers;
  /// 'input' with [inputNeuronCount] neurons and 'output' with 1 neuron.
  Perceptron({
    required int inputNeuronCount,
    required ActivationAlgorithm activationAlgorithm,
  }) : super(
            layerSizes: [inputNeuronCount, 1],
            activationAlgorithm: activationAlgorithm);
}
