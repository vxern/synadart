import 'dart:io';

import 'package:synadart/src/activation.dart';
import 'package:synadart/src/layer.dart';
import 'package:synadart/src/logger.dart';

/// Representation of a Neural Network, which contains `Layer`s, each containing a number of `Neuron`s. A `Network` takes
/// an input in the form of several entries and returns an output by processing the data, passing the data through each
/// layer.
/// 
/// `Network`s must have a training mixin in order to be able to learn.
class Network {
  final Stopwatch stopwatch = Stopwatch();
  final Logger log = Logger('Network');

  /// List containing the `Layer`s inside this `Network`.
  final List<Layer> layers = [];

  /// Creates a `Network` with the specified `ActivationAlgorithm` which is then passed to and resolved by `Layer`s.
  /// 
  /// [activationAlgorithm] - The algorithm used for 'activating' `Neurons` inside this network, or indicating
  /// how 'active' this `Network`'s `Neuron`s are by shrinking the weighted sum of each `Neurons`'s [weights] and [inputs]
  /// to a more controlled range, such as 0 to 1.
  /// 
  /// [layerSizes] - Sizes of each respective `Layer` inside this `Network`. [layerSizes] must contain at least two
  /// entries - the first one being the input `Layer` and the last one being the output `Layer`.
  /// 
  /// [learningRate] - A value between 0 (exclusive) and 1 (inclusive) that indicates how sensitive this `Network`'s
  /// `Neuron`s are to adjustments of their [weights].
  Network({
    required ActivationAlgorithm activationAlgorithm,
    required List<int> layerSizes,
    required double learningRate,
  }) {
    if (layerSizes.length < 2) {
      log.error('A network must contain at least two layers.');
      exit(0);
    }

    if (layerSizes.contains(0)) {
      log.error('One or more layer size is equal to 0.');
      exit(0);
    }

    // Create layers according to the specified layer sizes
    for (int size in layerSizes) {
      layers.add(Layer(
        activationAlgorithm: activationAlgorithm,
        // If the layer is an input layer, initialise it with 0 parent neurons.
        // Otherwise, initialise it with the amount the previous layer contains.
        parentLayerNeuronCount: layers.isEmpty ? 0 : layers[layers.length - 1].neurons.length,
        neuronCount: size,
        learningRate: learningRate,
      ));
    }
  }

  /// Processes [inputs], propagating them across every `Layer`, processing each `Layer` one-by-one
  /// and returns the output.
  List<double> process(List<double> inputs) {
    List<double> output = inputs;

    for (final layer in layers) {
      layer.accept(output);
      output = layer.output;
    }

    return output;
  }
}
