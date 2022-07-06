import 'package:synadart/src/networks/network.dart';
import 'package:synadart/src/networks/training/backpropagation.dart';

/// A `Network` model in which every `Layer` has one input and one output
/// tensor.
class Sequential extends Network with Backpropagation {
  /// Creates a `Sequential` model network.
  Sequential({
    required super.learningRate,
    super.layers,
  });
}
