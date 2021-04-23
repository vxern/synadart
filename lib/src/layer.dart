import 'package:synadart/src/activation.dart';
import 'package:synadart/src/neuron.dart';
import 'package:synadart/src/utils/mathematical_operations.dart';

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

    this.neurons = List.generate(neuronCount, (_) => Neuron(
      activationAlgorithm: activationAlgorithm,
      parentNeuronCount: parentLayerNeuronCount,
    ));
  }
  
  /// Accept [inputs] and pass the same input to each `Neuron`
  /// 
  /// If [isInputLayer] is true, each `Neuron` in this `Layer` will accept an input
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

  /// Adjusts weights of each `Neuron` according to its respective [errorMargin] and
  /// returns new [weightMargins] for the previous (we are moving backwards) `Layer`
  List<double> propagate(List<double> weightMargins) {
    final List<List<double>> newWeightMargins = [];

    for (final neuron in neurons) {
      if (neuron.isInput) {
        continue;
      }

      newWeightMargins.add(
        neuron.adjust(
          weightMargin: weightMargins.removeAt(0)
        )
      );
    }

    return newWeightMargins.reduce((a, b) => add(a, b));
  }

  /// Returns a list of the neurons' outputs
  List<double> process() {
    final List<double> response = [];

    for (final neuron in neurons) {
      response.add(neuron.output);
    }

    return response;
  }
}