import 'package:neural_network/src/activation.dart';
import 'package:neural_network/src/neuron.dart';

class Layer {
  late final List<Neuron> neurons;

  final bool isInputLayer;

  Layer({
    required int parentNeuronCount,
    required int neuronCount,
    required ActivationAlgorithm activationAlgorithm,
    this.isInputLayer = false,
  }) {
    neurons = List.filled(neuronCount, Neuron(
      parentNeuronCount: parentNeuronCount,
      activationAlgorithm: activationAlgorithm,
    ));
  }
}