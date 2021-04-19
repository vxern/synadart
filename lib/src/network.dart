import 'package:neural_network/src/activation.dart';
import 'package:neural_network/src/layer.dart';

class Network {
  final List<Layer> layers = [];

  Network({
    required List<int> layerSizes,
    required ActivationAlgorithm activationAlgorithm,
  }) {
    // Create layers according to the specified layer sizes
    for (int size in layerSizes) {
      layers.add(Layer(
        // The input layer does not have any parent neurons
        parentNeuronCount: layers.isEmpty ? 0 : layers[layers.length - 1].neurons.length, 
        neuronCount: size, 
        activationAlgorithm: activationAlgorithm
      ));
    }
  }
}