import 'package:synadart/src/layers/layer.dart';
import 'package:synadart/src/networks/network.dart';
import 'package:synadart/src/networks/training/backpropagation.dart';

/// A `Network` model in which every `Layer` has one input and one output
/// tensor.
class Sequential extends Network with Backpropagation {
  /// Creates a `Sequential` model network.
  Sequential({
    required double learningRate,
    List<Layer>? layers,
  }) : super(learningRate: learningRate, layers: layers);
}
