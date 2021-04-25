import 'package:synadart/src/activation.dart';
import 'package:synadart/src/network.dart';

/// Simple feed-forward network. One input layer, one hidden layer, one output layer.
class FeedForward extends Network {
  /// Takes [inputNeuronCount] and [hiddenNeuronCount] and constructs a network using three layers;
  /// 'input' with [inputNeuronCount] neurons, 'hidden' with [hiddenNeuronCount] neurons and 'output' with 1 neuron.
  FeedForward({
    required int inputNeuronCount,
    required int hiddenNeuronCount,
    required ActivationAlgorithm activationAlgorithm,
  }) : super(
            layerSizes: [inputNeuronCount, hiddenNeuronCount, 1],
            activationAlgorithm: activationAlgorithm);
}
