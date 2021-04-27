import 'package:synadart/src/activation.dart';
import 'package:synadart/src/network.dart';
import 'package:synadart/src/networks/training/backpropagation.dart';

/// Simple feed-forward network. One input layer, one hidden layer, one output layer.
class FeedForward extends Network with Backpropagation {
  /// Takes [inputNeuronCount] and [hiddenNeuronCount] and constructs a network using three layers;
  /// 'input' with [inputNeuronCount] neurons, 'hidden' with [hiddenNeuronCount] neurons and 'output' with 1 neuron.
  FeedForward({
    required ActivationAlgorithm activationAlgorithm,
    required int inputNeuronCount,
    required int hiddenNeuronCount,
  }) : super(
            activationAlgorithm: activationAlgorithm,
            layerSizes: [inputNeuronCount, hiddenNeuronCount, 1]);
}
