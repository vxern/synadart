import 'package:extended_math/extended_math.dart';

import 'package:neural_network/src/activation.dart';

class Neuron {
  final Vector inputs;
  final Vector weights;

  final int parentNeuronCount;
  final num momentum;
  final num bias;
  final num Function() activate;

  Neuron({
    this.inputs = const Vector([]),
    this.weights = const Vector([]),

    required this.parentNeuronCount,
    required this.momentum,
    required this.bias,
    required ActivationFunction activationFunction,
  }) : activate = Activation.resolveFunction(
    activationFunction, 
    momentum: momentum, 
    weightedSum: inputs.dot(weights)
  );
}