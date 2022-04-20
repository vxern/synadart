import 'package:synadart/src/activation.dart';
import 'package:synadart/src/layers/layer.dart';

/// A `Layer` in which every `Neuron` is connected to every other `Neurons` in
/// the preceding `Layer`.
class Dense extends Layer {
  /// Construct a dense layer using the [activation] algorithm and [size].
  Dense({
    required int size,
    required ActivationAlgorithm activation,
  }) : super(size: size, activation: activation);
}
