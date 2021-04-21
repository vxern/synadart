import 'dart:math';

typedef ActivationFunction = double Function(double Function());

/// Takes an `ActivationAlgorithm` and returns the `ActivationFunction`
/// that is defined by the algorithm
ActivationFunction resolveActivationAlgorithm(ActivationAlgorithm activationAlgorithm) {
  switch (activationAlgorithm) {
    case ActivationAlgorithm.Sigmoid:
      return (double Function() weightedSum) => sigmoid(weightedSum()); 
    case ActivationAlgorithm.ReLU:
      return (double Function() weightedSum) => relu(weightedSum()); 
  }
}

ActivationFunction resolveDerivative(ActivationAlgorithm activationAlgorithm) {
  switch (activationAlgorithm) {
    case ActivationAlgorithm.Sigmoid:
      return (double Function() weightedSum) => sigmoidPrime(weightedSum());
    case ActivationAlgorithm.ReLU:
      return (double Function() weightedSum) => reluPrime(weightedSum());
  }
}

double sigmoid(double x) => 1 / (1 + exp(-x));
double sigmoidPrime(double x) => sigmoid(x) * (1 - sigmoid(x));

double relu(double x) => max(0, x);
double reluPrime(double x) => x <= 0 ? 0 : 1;

/// Available algorithms for neuron activation
enum ActivationAlgorithm {
  Sigmoid,
  ReLU,
}