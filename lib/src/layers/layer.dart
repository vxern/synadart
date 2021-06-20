import 'dart:io';

import 'package:sprint/sprint.dart';

import 'package:synadart/src/activation.dart';
import 'package:synadart/src/neurons/neuron.dart';
import 'package:synadart/src/utils/mathematical_operations.dart';

/// Representation of a single `Layer` inside a `Network` - a 'column' of `Neurons` which can be
/// manipulated through accepting new data, propagated through training or simply processed the output of.
class Layer {
  /// I don't know how to document this one
  final Sprint log = Sprint('Layer');

  /// The `ActivationAlgorithm` used for activating `Neurons` inside this `Layer`.
  final ActivationAlgorithm activation;

  /// List containing the `Neuron`s inside this `Layer`.
  final List<Neuron> neurons = [];

  /// The amount of `Neurons` this `Layer` comprises.
  final int size;

  /// Specifies whether this `Layer` is an input `Layer`. This is used to determine how inputs should be
  /// accepted by each neuron in this `Layer`.
  bool isInput = false;

  /// Creates a `Layer` with the specified `ActivationAlgorithm` which is then passed to and resolved by `Neuron`s.
  ///
  /// [size] - The amount of `Neuron`s this `Layer` has.
  ///
  /// [activation] - The algorithm used for 'activating' this `Layer`'s `Neuron`s, or indicating
  /// how 'active' this `Layer`'s `Neuron`s are by shrinking the weighted sum of a `Neuron`'s [weights] and [inputs]
  /// to a more controlled range, such as 0 to 1.
  Layer({
    required this.size,
    required this.activation,
  }) {
    if (size < 1) {
      log.error('A layer must contain at least one neuron.');
      exit(0);
    }
  }

  /// Initialises this `Layer` with parameters passed in by the `Network`
  ///
  /// [parentNeuronCount] - The amount of 'connections' this `Layer` has, or how many `Neuron`s the previous
  /// `Layer` contains.
  ///
  /// This number will equal zero if this `Layer` is an input `Layer`.
  ///
  /// [learningRate] - A value between 0 (exclusive) and 1 (inclusive) that indicates how sensitive
  /// this `Layer`'s `Neuron`s are to adjustments of their [weights].
  void initialise({
    required int parentLayerSize,
    required double learningRate,
  }) {
    isInput = parentLayerSize == 0;

    neurons.addAll(Iterable.generate(
      size,
      (_) => Neuron(
        activationAlgorithm: activation,
        parentNeuronCount: parentLayerSize,
        learningRate: learningRate,
      ),
    ));
  }

  /// Accept a single [input] or multiple [inputs] by assigning them to every of this `Layer`'s `Neuron`'s [inputs].
  ///
  /// If [isInput] is true, each `Neuron` in this `Layer` will only accept a single input corresponding
  /// to its index in the [neurons] list.
  void accept(List<double> inputs) {
    if (isInput) {
      for (int index = 0; index < neurons.length; index++) {
        neurons[index].accept(input: inputs[index]);
      }
      return;
    }

    for (final neuron in neurons) {
      neuron.accept(inputs: inputs);
    }
  }

  /// Adjust weights of each `Neuron` based on its respective [weightMargin] and return
  /// new [weightMargins] for the previous `Layer` (We are moving backwards during propagation).
  List<double> propagate(List<double> weightMargins) {
    final List<List<double>> newWeightMargins = [];

    for (final neuron in neurons) {
      newWeightMargins
          .add(neuron.adjust(weightMargin: weightMargins.removeAt(0)));
    }

    return newWeightMargins.reduce((a, b) => add(a, b));
  }

  /// Returns a list of this `Layer`'s `Neuron`s' outputs
  List<double> get output =>
      List<double>.from(neurons.map<double>((neuron) => neuron.output));
}
