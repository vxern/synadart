import 'package:synadart/src/networks/simple/feedforward.dart';
import 'package:synadart/synadart.dart';

void main() {
  final network = FeedForward(
    layerSizes: [15, 5, 1],
    activationAlgorithm: ActivationAlgorithm.sigmoid,
    learningRate: 0.3,
  );
}
