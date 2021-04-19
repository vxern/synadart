import 'package:neural_network/src/activation.dart';
import 'package:neural_network/src/neuron.dart';

class Layer {
  late final List<Neuron> neurons;

  late final bool isInputLayer;

  Layer({
    required int parentNeuronCount,
    required int neuronCount,
    required ActivationAlgorithm activationAlgorithm,
  }) {
    isInputLayer = parentNeuronCount == 0;

    neurons = List.filled(neuronCount, Neuron(
      parentNeuronCount: parentNeuronCount,
      activationAlgorithm: activationAlgorithm,
    ));
  }
  
  /// Accept [input] and pass the same input to each neuron
  /// 
  /// If [isInputLayer] is true, each neutron in this layer will
  /// receive its respective input
  void accept(List<double> input) {
    if (!isInputLayer) {
      for (final neuron in neurons) {
        neuron.inputs = input;
      }
      return;
    }

    for (int index = 0; index < neurons.length; index++) {
      neurons[index].inputs = [input[index]];
    }
  }
}