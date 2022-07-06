import 'dart:math';

import 'package:synadart/src/utils/mathematical_operations.dart';

/// Type defining an activation function taking as a parameter the function to
/// obtain the weighted sum of the inputs and the weights.
typedef ActivationFunction = double Function(double Function());

/// Type defining a bare activation function.
typedef ActivationFunctionSignature = double Function(double);

/// Map containing all available activation algorithms and their derivatives.
const algorithms = <ActivationAlgorithm, List<ActivationFunctionSignature>>{
  ActivationAlgorithm.sigmoid: [sigmoid, sigmoidPrime],
  ActivationAlgorithm.relu: [relu, reluPrime],
  ActivationAlgorithm.lrelu: [lrelu, lreluPrime],
  ActivationAlgorithm.elu: [elu, eluPrime],
  ActivationAlgorithm.selu: [selu, seluPrime],
  ActivationAlgorithm.tanh: [tanh, tanhPrime],
  ActivationAlgorithm.softplus: [softplus, softplusPrime],
  ActivationAlgorithm.softsign: [softsign, softsignPrime],
  ActivationAlgorithm.swish: [swish, swishPrime],
  ActivationAlgorithm.gaussian: [gaussian, gaussianPrime],
};

/// Resolves an `ActivationAlgorithm` to a mathematical function in the form of
/// an `ActivationFunction`.
ActivationFunction resolveActivationAlgorithm(
  ActivationAlgorithm activationAlgorithm,
) =>
    (weightedSum) => algorithms[activationAlgorithm]!.first(weightedSum());

/// Resolves an `ActivationAlgorithm` to the derivative of the mathematical
/// function in the form of an `ActivationFunction`
ActivationFunction resolveActivationDerivative(
  ActivationAlgorithm activationAlgorithm,
) =>
    (weightedSum) => algorithms[activationAlgorithm]!.last(weightedSum());

/// Shrinks the range of values to inbetween 0 and 1 using exponentials. Results
/// can be driven into saturation, which makes the sigmoid function unsuited for
/// deep networks with random initialisation.
double sigmoid(double x) => 1 / (1 + exp(-x));

/// Rectified Linear Unit - Negative integers adjusted to 0, leaving positive
/// ones untouched.
double relu(double x) => max(0, x);

/// Leaky Linear Unit - Shallow line is seen in the negative x- and y-axes,
/// instead of reducing result to 0 like ReLU.
double lrelu(double x) => max(0.01 * x, x);

/// Exponential Linear Unit - Provides a smooth descent below 0, towards the
/// negative of [hyperparameter], or returns [x] if above or equal to 0.
double elu(double x, [double hyperparameter = 1]) =>
    x >= 0 ? x : hyperparameter * (exp(x) - 1);

/// Scaled Exponential Linear Unit - Ensures a slope larger than one for
/// positive inputs.
double selu(double x) => 1.0507 * (x < 0 ? 1.67326 * (exp(x) - 1) : x);

/// Hyperbolic Tangent - Utilises exponentials in order to shrink a range of
/// numbers to strictly in-between -1 and 1, -1 and 1 being the mfunction's
/// asymptotes, towards which the curve tends.
double tanh(double x) => (exp(x) - exp(-x)) / (exp(x) + exp(-x));

/// Similar to ReLU, but there is a smooth (soft) curve as the result approaches
/// zero on the negative x-axis.  Softplus is strictly positive and monotonic.
double softplus(double x) => log(exp(x) + 1);

/// Similar to the hyperbolic tangent, but its tails are quadratic polynomials,
/// rather than exponentials, therefore causing the curve to approach its
/// asymptotes much more slowly.
double softsign(double x) => x / (1 + abs(x));

/// Similar to ReLU and Softplus; negative results do occur, but they approach 0
/// up until x ≈ -10.  Delivers comparable or superior results to ReLU.
double swish(double x) => x * sigmoid(x);

/// Symmetrical and bell-shaped graph with a peak at 1 and a smooth approach to
/// 0 for both sides of the x-axis.
double gaussian(double x) => exp(-pow(x, 2));

/// The derivative of the Sigmoid.
double sigmoidPrime(double x) => sigmoid(x) * (1 - sigmoid(x));

/// The derivative of ReLU.
double reluPrime(double x) => x < 0 ? 0 : 1;

/// The derivative of LReLU.
double lreluPrime(double x) => x < 0 ? 0.01 : 1;

/// The derivative of ELU.
double eluPrime(double x, [double hyperparameter = 1]) =>
    x > 0 ? 1 : elu(x, hyperparameter) + hyperparameter;

/// The derivative of the Scaled Exponential Linear Unit
double seluPrime(double x) => 1.0507 * (x < 0 ? 1.67326 * exp(x) : 1);

/// The derivative of the Hyperbolic Tangent
double tanhPrime(double x) => 1.0 - pow(tanh(x), 2);

/// The derivative of the Softplus
double softplusPrime(double x) => sigmoid(x);

/// The derivative of the Softsign
double softsignPrime(double x) => 1 / pow(1 + abs(x), 2);

/// The derivative of the Swish
double swishPrime(double x) => swish(x) + sigmoid(x) * (1 - swish(x));

/// The derivative of the Gaussian
double gaussianPrime(double x) => -2 * x * gaussian(x);

/// Algorithms which can be used for activating `Neuron`s
enum ActivationAlgorithm {
  /// Sigmoid
  sigmoid,

  /// Rectified Linear Unit
  relu,

  /// Leaky Rectified Linear Unit
  lrelu,

  /// Exponential Linear Unit
  elu,

  /// Scaled Exponential Linear Unit
  selu,

  /// Hyperbolic tangent
  tanh,

  /// Softplus
  softplus,

  /// Softsign
  softsign,

  /// Swish
  swish,

  /// Gaussian
  gaussian,
}
