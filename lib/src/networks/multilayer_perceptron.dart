import 'package:synadart/src/activation.dart';
import 'package:synadart/src/network.dart';

class MultilayerPerceptron extends Network {
  MultilayerPerceptron({
    required List<int> layerSizes,
    required ActivationAlgorithm activationAlgorithm,
  }) : super(layerSizes: layerSizes, activationAlgorithm: activationAlgorithm);
}
