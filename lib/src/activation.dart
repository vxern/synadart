import 'dart:math';

typedef ActivationFunction = double Function(double Function());

/// Takes an `ActivationAlgorithm` and returns the `ActivationFunction`
/// that is defined by the algorithm
ActivationFunction resolveActivationAlgorithm(
    ActivationAlgorithm activationAlgorithm) {
  switch (activationAlgorithm) {
    case ActivationAlgorithm.logistic:
      return (double Function() weightedSum) => logistic(weightedSum());
    case ActivationAlgorithm.relu:
      return (double Function() weightedSum) => relu(weightedSum());
    case ActivationAlgorithm.lrelu:
      return (double Function() weightedSum) => lrelu(weightedSum());
    case ActivationAlgorithm.elu:
      return (double Function() weightedSum) => elu(weightedSum());
    case ActivationAlgorithm.tanh:
      return (double Function() weightedSum) => tanh(weightedSum());
  }
}

ActivationFunction resolveDerivative(ActivationAlgorithm activationAlgorithm) {
  switch (activationAlgorithm) {
    case ActivationAlgorithm.logistic:
      return (double Function() weightedSum) => logisticPrime(weightedSum());
    case ActivationAlgorithm.relu:
      return (double Function() weightedSum) => reluPrime(weightedSum());
    case ActivationAlgorithm.lrelu:
      return (double Function() weightedSum) => lreluPrime(weightedSum());
    case ActivationAlgorithm.elu:
      return (double Function() weightedSum) => eluPrime(weightedSum());
    case ActivationAlgorithm.tanh:
      return (double Function() weightedSum) => tanhPrime(weightedSum());
  }
}

// Logistic functions
double logistic(double x) => 1 / (1 + exp(-x));
double logisticPrime(double x) => logistic(x) * (1 - logistic(x));

// Linear unit functions
double relu(double x) => max(0, x);
double reluPrime(double x) => x <= 0 ? 0 : 1;
double lrelu(double x) => max(0.1 * x, x);
double lreluPrime(double x) => x <= 0 ? 0.1 : 1;
double elu(double x, [double hyperparameter = 1]) =>
    x > 0 ? x : hyperparameter * (exp(x) - 1);
double eluPrime(double x, [double hyperparameter = 1]) =>
    x > 0 ? 1 : elu(x, hyperparameter) + hyperparameter;

// Hyperbolic functions
double tanh(double x) => (exp(x) - exp(-x)) / (exp(x) + exp(-x));
double tanhPrime(double x) => 1.0 - pow(tanh(x), 2);

/// Available algorithms for neuron activation
enum ActivationAlgorithm {
  logistic, // Logistic ( Sigmoid ) activation

  relu, // Rectified Linear Unit
  lrelu, // Leaky Rectified Linear Unit
  elu, // Exponential Linear Unit

  tanh, // Hyperbolic tangent
}
