import 'package:neural_network/src/activation.dart';
import 'package:neural_network/src/neuron.dart';

/// A neural layer consisting of two or more neurons
class Layer {
  final List<Neuron> neurons;

  Layer({
    required int neuronCount,
    required int parentNeuronCount,

    required num momentum,
    required num bias,
    required ActivationFunction activationFunction,
  }) : neurons = List.filled(neuronCount, Neuron(
    parentNeuronCount: parentNeuronCount,
    momentum: momentum,
    bias: bias,
    activationFunction: activationFunction,
  ));
}