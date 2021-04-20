import 'package:neural_network/src/activation.dart';
import 'package:neural_network/src/neuron.dart';

/// Representation of single column or collection of `neurons`
class Layer {
  late final List<Neuron> neurons;

  late final bool isInputLayer;

  /// [activationAlgorithm] - The algorithm that should be used as the activation function of this layer's neurons
  /// [parentLayerNeuronCount] - How many neurons the parent layer contains
  /// [neuronCount] - How many neurons this layer should contain
  Layer({
    required ActivationAlgorithm activationAlgorithm,
    required int parentLayerNeuronCount,
    required int neuronCount,
  }) {
    assert(parentLayerNeuronCount >= 0, '`parentLayerNeuronCount` must not be negative');

    isInputLayer = parentLayerNeuronCount == 0;

    neurons = List.filled(neuronCount, Neuron(
      activationAlgorithm: activationAlgorithm,
      parentNeuronCount: parentLayerNeuronCount,
    ));
  }
  
  /// Accept [inputs] and pass the same input to each neuron
  /// 
  /// If [isInputLayer] is true, each neutron in this layer will accept an input
  void accept(List<double> inputs) {
    if (!isInputLayer) {
      for (final neuron in neurons) {
        neuron.accept(inputs: inputs);
      }
      return;
    }

    for (int index = 0; index < neurons.length; index++) {
      neurons[index].accept(input: inputs[index]);
    }
  }
}