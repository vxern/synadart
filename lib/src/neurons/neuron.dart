import 'dart:io';
import 'dart:math';

import 'package:sprint/sprint.dart';

import 'package:synadart/src/activation.dart';
import 'package:synadart/src/utils/mathematical_operations.dart';
import 'package:synadart/src/utils/value_generator.dart';

/// Representation of a single `Neuron` inside a `Network`. A `Neuron` can take on multiple forms and functions,
/// the most basic of which being the taking of the weighted sum of [inputs] and [weights], and passing it further
/// to the next `Neuron`.
class Neuron {
  final Sprint log = Sprint('Neuron');

  /// `ActivationAlgorithm` in the form of a mathematical function which can be resolved when needed.
  late final ActivationFunction activation;

  /// The derivative of the `ActivationAlgorithm`.
  late final ActivationFunction activationPrime;

  /// The sensitivity of this `Neuron` to the function adjusting [weights] during training.
  ///
  /// The [learningRate] must be a value between 0 (exclusive) and 1 (inclusive).
  final double learningRate;

  /// Weights of connections to previous `Neuron`s, which can be imagined as how influential each
  /// connection is on this `Neuron`'s [output].
  List<double> weights = [];

  /// Inputs received from the previous `Layer`, which are combined with [weights] of connections to
  /// `Neurons`s from the previous `Layer` in order to create an [output].
  List<double> inputs = [];

  /// Specifies whether this `Neuron` belongs to an input `Layer`. This is used to determine the source of
  /// output because a parentless `Neuron` will not have any connections.
  bool isInput = false;

  /// Creates a `Neuron` with the specified `ActivationAlgorithm` which is then resolved to an `ActivationFunction`.
  ///
  /// [activationAlgorithm] - The algorithm used for 'activating' this `Neuron`, or indicating
  /// how 'active' this `Neuron` is by shrinking the weighted sum of this `Neuron`'s [weights] and [inputs]
  /// to a more controlled range, such as 0 to 1.
  ///
  /// [parentNeuronCount] - The amount of 'connections' this `Neuron` has, or how many `Neuron`s
  /// from the previous layer this `Neuron` is connected to.
  ///
  /// [learningRate] - A value between 0 (exclusive) and 1 (inclusive) that indicates how sensitive
  /// this `Neuron` is to adjustments of [weights].
  ///
  /// [weights] - (Optional) Weights of connections to `Neuron`s in the previous `Layer`.
  /// If [weights] have not been provided, they will be generated randomly.
  Neuron(
      {required ActivationAlgorithm activationAlgorithm,
      required int parentNeuronCount,
      required this.learningRate,
      List<double> weights = const []}) {
    activation = resolveActivationAlgorithm(activationAlgorithm);
    activationPrime = resolveDerivative(activationAlgorithm);

    if (parentNeuronCount == 0) {
      this.isInput = true;
      this.weights.add(1);
      return;
    }

    if (weights.isEmpty) {
      // Calculate the range extrema based on the number of parent neurons
      final double limit = 1 / sqrt(parentNeuronCount);
      // Generate random values for the weights of connections
      this.weights.addAll(ValueGenerator.generateListWithRandomDoubles(
          size: parentNeuronCount, from: -limit, to: limit));
      return;
    }

    if (weights.length != parentNeuronCount) {
      log.error(
          'The amount of weights supplied to this neuron does not match the amount'
          'of connections to neurons in the parent layer.');
      exit(0);
    }

    this.weights = weights;
    return;
  }

  /// Accept a single [input] or multiple [inputs] by assigning them to this `Neuron`'s [inputs].
  void accept({List<double>? inputs, double? input}) {
    if (inputs == null && input == null) {
      log.error('Attempted to accept without any inputs.');
      exit(0);
    }

    if (!isInput && inputs != null) {
      this.inputs = inputs;
      return;
    }

    if (this.inputs.isNotEmpty) {
      this.inputs[0] = input!;
    } else {
      this.inputs.add(input!);
    }
  }

  /// Adjust this `Neuron`'s [weights] and return their adjusted values
  List<double> adjust({required double weightMargin}) {
    final List<double> adjustedWeights = [];

    for (int index = 0; index < weights.length; index++) {
      adjustedWeights.add(weightMargin * weights[index]);
      weights[index] -= learningRate *
          -weightMargin * // TODO: Shouldn't this logically be δC/δa?
          activationPrime(() => dot(inputs, weights)) * // δa/δz
          inputs[index]; // δz/δw
    }

    return adjustedWeights;
  }

  /// If this `Neuron` is an 'input' `Neuron`, it should output its sole input because it has no parent neurons
  /// and therefore no weights of connections.
  /// Otherwise, it should output the weighted sum of the [inputs] and [weights], passed through the [activationFunction].
  double get output =>
      weights.isEmpty ? inputs[0] : activation(() => dot(inputs, weights));
}
