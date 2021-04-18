import 'package:calc/calc.dart';

typedef ActivationFunction = double Function(double Function() weightedSum);

/// Takes an `ActivationAlgorithm` and returns the `ActivationFunction`
/// that is defined by the algorithm
ActivationFunction resolveActivationAlgorithm(ActivationAlgorithm activationAlgorithm) {
  switch (activationAlgorithm) {
    case ActivationAlgorithm.Sigmoid:
      return (double Function() weightedSum) => 1 / (1 + exp(-weightedSum())); 
    case ActivationAlgorithm.ReLU:
      return (double Function() weightedSum) => max(0, weightedSum()); 
  }
}

/// Available algorithms for neuron activation
enum ActivationAlgorithm {
  Sigmoid,
  ReLU,
}