import 'dart:math';

import 'package:synadart/src/utils/mathematical_operations.dart';

typedef ActivationFunction = double Function(double Function());

/// Resolves an `ActivationAlgorithm` to a mathematical function in the form of an `ActivationFunction`
ActivationFunction resolveActivationAlgorithm(ActivationAlgorithm activationAlgorithm) {
  switch (activationAlgorithm) {
    case ActivationAlgorithm.sigmoid:
      return (double Function() weightedSum) => sigmoid(weightedSum());
    
    case ActivationAlgorithm.relu:
      return (double Function() weightedSum) => relu(weightedSum());
    case ActivationAlgorithm.lrelu:
      return (double Function() weightedSum) => lrelu(weightedSum());
    case ActivationAlgorithm.elu:
      return (double Function() weightedSum) => elu(weightedSum());
    case ActivationAlgorithm.selu:
      return (double Function() weightedSum) => selu(weightedSum());

    case ActivationAlgorithm.tanh:
      return (double Function() weightedSum) => tanh(weightedSum());

    case ActivationAlgorithm.softplus:
      return (double Function() weightedSum) => softplus(weightedSum());
    case ActivationAlgorithm.softsign:
      return (double Function() weightedSum) => softsign(weightedSum());
    case ActivationAlgorithm.swish:
      return (double Function() weightedSum) => swish(weightedSum());
    case ActivationAlgorithm.gaussian:
      return (double Function() weightedSum) => gaussian(weightedSum());
  }
}

/// Resolves an `ActivationAlgorithm` to the derivative of the mathematical function in
/// the form of an `ActivationFunction`
ActivationFunction resolveDerivative(ActivationAlgorithm activationAlgorithm) {
  switch (activationAlgorithm) {
    case ActivationAlgorithm.sigmoid:
      return (double Function() weightedSum) => sigmoidPrime(weightedSum());

    case ActivationAlgorithm.relu:
      return (double Function() weightedSum) => reluPrime(weightedSum());
    case ActivationAlgorithm.lrelu:
      return (double Function() weightedSum) => lreluPrime(weightedSum());
    case ActivationAlgorithm.elu:
      return (double Function() weightedSum) => eluPrime(weightedSum());
    case ActivationAlgorithm.selu:
      return (double Function() weightedSum) => seluPrime(weightedSum());

    case ActivationAlgorithm.tanh:
      return (double Function() weightedSum) => tanhPrime(weightedSum());

    case ActivationAlgorithm.softplus:
      return (double Function() weightedSum) => softplusPrime(weightedSum());
    case ActivationAlgorithm.softsign:
      return (double Function() weightedSum) => softsignPrime(weightedSum());
    case ActivationAlgorithm.swish:
      return (double Function() weightedSum) => swishPrime(weightedSum());
    case ActivationAlgorithm.gaussian:
      return (double Function() weightedSum) => gaussianPrime(weightedSum());
  }
}

/// Shrinks the range of values to inbetween 0 and 1 using exponentials. Results can be driven into saturation,
/// which makes the sigmoid function unsuited for deep networks with random initialisation.
double sigmoid(double x) => 1 / (1 + exp(-x));
/// Rectified Linear Unit - Negative integers adjusted to 0, leaving positive ones untouched
double relu(double x) => max(0, x);
/// Leaky Linear Unit - Shallow line is seen in the negative x- and y-axes, instead of reducing result to 0 like ReLU.
double lrelu(double x) => max(0.01 * x, x);
/// Exponential Linear Unit function which provides a smooth descent below 0, towards the negative of
/// [hyperparameter], or returns [x] if above or equal to 0
double elu(double x, [double hyperparameter = 1]) => x >= 0 ? x : hyperparameter * (exp(x) - 1);
/// Scaled Exponential Linear Unit - Ensures a slope larger than one for positive inputs
double selu(double x) => 1.0507 * (x < 0 ? 1.67326 * (exp(x) - 1) : x);
/// Hyperbolic Tangent, which uses exponentials to shrink a range to inbetween -1 and 1, -1 and 1 being
/// the function's asymptotes, towards which the lines tend.
double tanh(double x) => (exp(x) - exp(-x)) / (exp(x) + exp(-x));
/// Similar to ReLU, but there is a smooth (soft) curve as result approaches zero on the negative x-axis.
/// Softplus is strictly positive and monotonic.
double softplus(double x) => log(exp(x) + 1);
/// Works similarly to the hyperbolic tangent but its tails are quadratic polynomials rather
/// than exponentials, therefore approaching its asymptotes much slower.
double softsign(double x) => x / (1 + abs(x));
/// Similar to ReLU and softplus, negative results do occur but approach 0 up until x ≈ -10. 
/// Delivers equal or better results to ReLU.
double swish(double x) => x * sigmoid(x);
/// Symmetrical and bell-shaped graph with a peak at 1 and a smooth approach to 0 for both sides
/// of the x-axis
double gaussian(double x) => exp(-pow(x, 2));

/// The derivative of the Sigmoid
double sigmoidPrime(double x) => sigmoid(x) * (1 - sigmoid(x));
/// The derivative of the Rectified Linear Unit
double reluPrime(double x) => x < 0 ? 0 : 1;
/// The derivative of the Leaky Linear Unit
double lreluPrime(double x) => x < 0 ? 0.01 : 1;
/// The derivative of the Exponential Linear Unit
double eluPrime(double x, [double hyperparameter = 1]) => x > 0 ? 1 : elu(x, hyperparameter) + hyperparameter;
/// The derivative of the Scaled Exponential Linear Unit
double seluPrime(double x) => 1.0507 * (x < 0 ? 1.67326 * exp(x) : 1);
/// The derivative of the Hyperbolic Tangent
double tanhPrime(double x) => 1.0 - pow(tanh(x), 2);
/// The derivative of the Softplus
double softplusPrime(double x) => sigmoid(x);
/// The derivative of the Softsign
double softsignPrime(double x) => 1 / pow((1 + abs(x)), 2);
/// The derivative of the Swish
double swishPrime(double x) => swish(x) + sigmoid(x) * (1 - swish(x));
/// The derivative of the Gaussian
double gaussianPrime(double x) => -2 * x * gaussian(x);

/// Algorithms which can be used for activating `Neuron`s
enum ActivationAlgorithm {
  sigmoid,

  relu, // Rectified Linear Unit
  lrelu, // Leaky Rectified Linear Unit
  elu, // Exponential Linear Unit
  selu, // Scaled Exponential Linear Unit

  tanh, // Hyperbolic tangent

  softplus,
  softsign,
  swish,
  gaussian,
}