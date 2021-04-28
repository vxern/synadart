import 'package:synadart/src/activation.dart';/*  */
import 'package:synadart/src/networks/network.dart';
import 'package:synadart/src/networks/training/backpropagation.dart';

// More complex perceptron model with one input, one or more hidden and one output layer
class MultilayerPerceptron extends Network with Backpropagation {
  /// Takes [layerSizes] and constructs a network using layers of each respective size
  /// in the list of layer sizes.
  MultilayerPerceptron({
    required ActivationAlgorithm activationAlgorithm,
    required List<int> layerSizes,
    required double learningRate,
  }) : super(
    activationAlgorithm: activationAlgorithm, 
    layerSizes: layerSizes,
    learningRate: learningRate,
  );
}
