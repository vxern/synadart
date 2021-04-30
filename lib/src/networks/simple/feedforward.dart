import 'dart:io';

import 'package:synadart/src/activation.dart';/*  */
import 'package:synadart/src/networks/network.dart';
import 'package:synadart/src/networks/training/backpropagation.dart';

/// A simple feed-forward `Network` model with a single input and output layer
class FeedForward extends Network with Backpropagation {
  /// Constructs a simple feed-forward `Network`
  FeedForward({
    required ActivationAlgorithm activationAlgorithm,
    required List<int> layerSizes,
    required double learningRate,
  }) : super(
    activationAlgorithm: activationAlgorithm, 
    layerSizes: layerSizes,
    learningRate: learningRate,
  ) {
    if (layerSizes.length > 2) {
      log.error('A simple feed-forward network model may only have two layers; input and output.'
                '\nConsider using a deep feed-forward network model instead.');
      exit(0);
    }
  }
}