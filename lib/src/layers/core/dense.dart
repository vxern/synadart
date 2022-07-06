import 'package:synadart/src/layers/layer.dart';

/// A `Layer` in which every `Neuron` is connected to every other `Neurons` in
/// the preceding `Layer`.
class Dense extends Layer {
  /// Construct a dense layer using the [activation] algorithm and [size].
  Dense({
    required super.size,
    required super.activation,
  });
}
