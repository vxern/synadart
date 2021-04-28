import 'dart:math';

typedef ActivationFunction = double Function(double Function());

/// Resolves an `ActivationAlgorithm` to a mathematical function in the form of an `ActivationFunction`
ActivationFunction resolveActivationAlgorithm(ActivationAlgorithm activationAlgorithm) {
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

/// Resolves an `ActivationAlgorithm` to the derivative of the mathematical function in
/// the form of an `ActivationFunction`
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

/// Logistic function, also called the `sigmoid` function, which shrinks a range to inbetween 0 and 1
double logistic(double x) => 1 / (1 + exp(-x));
/// The derivative of the logistic function
double logisticPrime(double x) => logistic(x) * (1 - logistic(x));

/// Rectified Linear Unit function which converts negative integers to 0, leaving positive ones untouched
double relu(double x) => max(0, x);
/// The derivative of the Rectified Linear Unit function which returns 0 if [x] is equal to or less than 0,
/// and 1 otherwise
double reluPrime(double x) => x <= 0 ? 0 : 1;
/// Leaky Linear Unit function which makes negative integers less significant by getting a tenth of them
double lrelu(double x) => max(0.1 * x, x);
/// The derivative of the Leaky Linear Unit function which returns 0.1 if [x] is equal to or less than 0,
/// and 1 otherwise
double lreluPrime(double x) => x <= 0 ? 0.1 : 1;
/// Exponential Linear Unit function which provides a smooth descent below 0, towards the negative of
/// [hyperparameter], or returns [x] if above or equal to 0
double elu(double x, [double hyperparameter = 1]) => x >= 0 ? x : hyperparameter * (exp(x) - 1);
/// The derivative of the Exponential Linear Unit function which returns 1 if [x] is greater than 0,
/// and the Exponential Linear Unit of [x] and [hyperparameter] moved up so the baseline is 0
double eluPrime(double x, [double hyperparameter = 1]) => x > 0 ? 1 : elu(x, hyperparameter) + hyperparameter;

/// Hyperbolic Tangent, which shrinks a range to inbetween -1 and 1
double tanh(double x) => (exp(x) - exp(-x)) / (exp(x) + exp(-x));
/// The derivative of the Hyperbolic Tangent function which returns a value increasingly
/// smaller the farther it is from the y-axis
double tanhPrime(double x) => 1.0 - pow(tanh(x), 2);

/// Algorithms which can be used for activating `Neuron`s
enum ActivationAlgorithm {
  logistic, // Logistic ( Sigmoid )

  relu, // Rectified Linear Unit
  lrelu, // Leaky Rectified Linear Unit
  elu, // Exponential Linear Unit

  tanh, // Hyperbolic tangent
}
