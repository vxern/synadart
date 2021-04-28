import 'dart:io';

import 'package:synadart/src/activation.dart';
import 'package:synadart/src/layer.dart';
import 'package:synadart/src/logger.dart';

class Network {
  final Stopwatch stopwatch = Stopwatch();
  final Logger log = Logger('Network');

  final List<Layer> layers = [];

  /// [activationAlgorithm] - The algorithm that should be used as the activation function of this network's layers
  /// [layerSizes] - List of sizes each layer should have
  Network({
    required ActivationAlgorithm activationAlgorithm,
    required List<int> layerSizes,
    required double learningRate,
  }) {
    if (layerSizes.length < 2) {
      log.warning('A network must contain at least two layers, otherwise it is not a network.');
      exit(0);
    }

    // Create layers according to the specified layer sizes
    for (int size in layerSizes) {
      layers.add(Layer(
        // The input layer does not have any parent layer neurons
        activationAlgorithm: activationAlgorithm,
        parentLayerNeuronCount: layers.isEmpty ? 0 : layers[layers.length - 1].neurons.length,
        neuronCount: size,
        learningRate: learningRate,
      ));
    }
  }

  /// Processes the input, utilising every layer and node and returns the network's response
  List<double> process(List<double> inputs) {
    List<double> response = inputs;

    for (final layer in layers) {
      layer.accept(response);
      response = layer.process();
    }

    return response;
  }
}
