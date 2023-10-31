import 'package:synadart/src/layers/layer.dart';

/// Representation of a neural network containing `Layers`, which each further
/// house a number of `Neurons`.  A `Network` takes an input in the form of
/// several entries and returns an output by processing the data by running the
/// data through the layers.
///
/// In order to train a `Network`, the selected `Network` must have a training
/// algorithm mixed into it - most commonly `Backpropagation`.
class Network {
  /// Used for performance analysis as well as general information logging.
  final Stopwatch stopwatch = Stopwatch();

  /// The `Layers` part of this `Network`.
  final List<Layer> layers = [];

  /// The degree of radicality at which the `Network` will adjust its `Neurons`
  /// weights.
  double learningRate;

  /// Creates a `Network` with optional `Layers`.
  ///
  /// [learningRate] - The level of aggressiveness at which this `Network` will
  /// adjust its `Neurons`' weights during training.
  ///
  /// [layers] - (Optional) The `Layers` of this `Network`.
  Network({required this.learningRate, List<Layer>? layers}) {
    if (layers != null) {
      addLayers(layers);
    }
  }

  /// Processes the [inputs] by propagating them across every `Layer`.
  /// and returns the output.
  List<double> process(List<double> inputs) {
    var output = inputs;

    for (final layer in layers) {
      layer.accept(output);
      output = layer.output;
    }

    return output;
  }

  /// Adds a `Layer` to this `Network`.
  void addLayer(Layer layer) {
    layer.initialise(
      parentLayerSize: layers.isEmpty ? 0 : layers.last.size,
      learningRate: learningRate,
    );

    layers.add(layer);
  }

  /// Adds a list of `Layers` to this `Network`.
  void addLayers(List<Layer> layers) {
    for (final layer in layers) {
      addLayer(layer);
    }
  }

  /// Clears the `Network` by removing all `Layers`, thereby returning it to its
  /// initial, empty state.
  ///
  /// ⚠️ Throws a [StateError] if the network has already been cleared.
  void clear() {
    if (layers.isEmpty) {
      throw StateError('Attempted to reset an already empty network.');
    }

    stopwatch.reset();
    layers.clear();
  }
}
