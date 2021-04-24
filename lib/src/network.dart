import 'package:synadart/src/activation.dart';
import 'package:synadart/src/layer.dart';
import 'package:synadart/src/logger.dart';
import 'package:synadart/src/utils/mathematical_operations.dart';

class Network {
  final Stopwatch stopwatch = Stopwatch();
  final Logger log = Logger('Network');

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

  /// Processes the input, utilising every layer and node and returns the network's response
  List<double> process(List<double> inputs) {
    List<double> response = inputs;

    for (final layer in layers) {
      layer.accept(response);
      response = layer.process();
    }

    return response;
  }

  /// Perform the `backpropagation` algorithm
  void propagateBackwards(List<double> input, List<double> expected) {
    final observed = process(input);

    List<double> errors = subtract(expected, observed);

    for (int index = layers.length - 1; index > 0; index--) {
      errors = layers[index].propagate(errors);
    }
  }

  /// Train the perceptron by passing in [input], their respective [expectedResults]
  /// as well as the number of iterations to make over these inputs
  void train({
    required List<List<double>> input,
    required List<List<double>> expected,
    required int iterations,
  }) {
    if (input.isEmpty || expected.isEmpty) {
      log.warning('[input] and [expected] fields must not be empty.');
      return;
    }

    if (input.length != expected.length) {
      log.warning('[input] and [expected] fields must be of the same length.');
      return;
    }

    if (iterations < 1) {
      log.warning('You cannot train a network without granting it at least one iteration.');
      return;
    }

    print('Training network with $iterations iterations...');
    stopwatch.start();
    for (int iteration = 0; iteration < iterations; iteration++) {
      for (int index = 0; index < input.length; index++) {
        propagateBackwards(input[index], expected[index]);
      }
    }
    stopwatch.stop();
    print('Training complete in ${stopwatch.elapsedMilliseconds / 1000}s');
  }
}