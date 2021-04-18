import 'package:neural_network/src/activation.dart';
import 'package:vector_math/vector_math.dart';

class Neuron {
  final Vector2 inputs;
  final Vector2 weights;
  late final ActivationFunction activation;

  Neuron({
    required this.inputs,
    required this.weights,
    required ActivationAlgorithm activationAlgorithm,
  }) {
    activation = resolveActivationAlgorithm(ActivationAlgorithm.ReLU);
  }

  /// Get the output of this neuron by taking the weighted sum
  double get output => activation(() => inputs.dot(weights));
}