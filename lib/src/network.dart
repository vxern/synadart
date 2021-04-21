import 'package:synadart/src/activation.dart';
import 'package:synadart/src/layer.dart';
import 'package:synadart/src/utils/mathematical_operations.dart';

class Network {
  final List<Layer> layers = [];

  /// [activationAlgorithm] - The algorithm that should be used as the activation function of this network's layers
  /// [layerSizes] - List of sizes each layer should have
  Network({
    required ActivationAlgorithm activationAlgorithm,
    required List<int> layerSizes,
  }) {
    // Create layers according to the specified layer sizes
    for (int size in layerSizes) {
      layers.add(Layer(
        // The input layer does not have any parent layer neurons
        parentLayerNeuronCount: layers.isEmpty ? 0 : layers[layers.length - 1].neurons.length, 
        neuronCount: size, 
        activationAlgorithm: activationAlgorithm
      ));
    }
  }

  /// Processes the input, utilising every layer, and node and returns the network's response
  List<double> process(List<double> input) {
    List<double> response = input;

    for (final layer in layers) {
      layer.accept(response);
      response = layer.process();
    }

    return response;
  }

  /// Perform the `backpropagation` algorithm
  void propagateBackwards(List<double> input, List<double> expected) {
    final observed = process(input);

    print('Observed: $observed');
    print('Expected: $expected');

    List<double> errors = subtract(expected, observed);

    print('Errors: $errors');

    for (int index = layers.length - 1; index > 0; index--) {
      print('Propagating layer #${index}');
      errors = layers[index].propagate(errors);
    }
  }

  /// Train the perceptron by passing in [inputs], their respective [expectedResults]
  /// as well as the number of iterations to make over these inputs
  void train({
    required List<List<double>> inputs,
    required List<List<double>> expected,
    required int iterations,
  }) {
    for (int iteration = 0; iteration < iterations; iteration++) {
      for (int index = 0; index < inputs.length; index++) {
        propagateBackwards(inputs[index], expected[index]);
      }
    }
  }
}