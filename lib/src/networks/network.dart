import 'package:sprint/sprint.dart';

import 'package:synadart/src/layers/layer.dart';

/// Representation of a Neural Network, which contains `Layers`, each containing a number of `Neurons`. A `Network` takes
/// an input in the form of several entries and returns an output by processing the data, passing the data through each
/// layer.
///
/// `Network`s must have a training mixin in order to be able to learn.
class Network {
  /// Used for performance analysis as well as general information logging
  final Stopwatch stopwatch = Stopwatch();

  final Sprint log = Sprint('Network');

  /// List containing the `Layers` inside this `Network`.
  final List<Layer> layers = [];

  double learningRate;

  /// Creates a `Network` with optional `Layers`
  Network({required this.learningRate, List<Layer>? layers}) {
    if (layers != null) {
      addLayers(layers);
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

  /// Adds a `Layer` to this `Network`
  void addLayer(Layer layer) {
    layer.initialise(
        parentLayerSize: layers.isEmpty ? 0 : layers[layers.length - 1].size,
        learningRate: learningRate);

    layers.add(layer);

    log.info('Added layer of size ${layer.neurons.length}.');
  }

  /// Adds a list of `Layers` to this `Network`
  void addLayers(List<Layer> layers) {
    for (final layer in layers) {
      addLayer(layer);
    }
  }

  /// Resets the `Network` by removing all `Layers`
  void reset() {
    if (layers.isEmpty) {
      log.warning('Attempted to reset an already empty network');
      return;
    }

    stopwatch.reset();
    layers.clear();

    log.success('Network reset successfully.');
  }
}
