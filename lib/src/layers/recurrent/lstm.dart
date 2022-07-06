import 'package:synadart/src/activation.dart';
import 'package:synadart/src/layers/layer.dart';

/// A `Layer` in which every `Neuron` is connected to every other `Neuron` in
/// the preceding `Layer`, with additional memory/retention capabilities.
class LSTM extends Layer {
  /// Activation function of the LSTM layer.
  late final ActivationFunction recurrenceActivation;

  /// Memory carried across all `Neurons` inside the layer.
  double longTermMemory = 1;

  /// Memory carried over from the current `Neuron` to the following `Neuron`.
  double shortTermMemory = 1;

  /// Construct an LSTM layer.
  ///
  /// [size] - How many `Neurons` this `LSTM` has.
  ///
  /// [activation] - Algorithm used to activate `Neurons` in this `Layer`.
  ///
  /// [recurrenceActivation] - Algorithm used to activate recurrence
  /// connections.
  LSTM({
    required super.size,
    required super.activation,
    required ActivationAlgorithm recurrenceActivation,
  }) : recurrenceActivation = resolveActivationAlgorithm(recurrenceActivation);

  /// Obtain the output by applying the recurrent memory algorithm.
  @override
  List<double> get output {
    final output = <double>[];

    for (final neuron in neurons) {
      final neuronOutput = neuron.output;
      final hiddenActivationComponent = neuron.activation(() => neuronOutput);
      final hiddenRecurrentComponent = recurrenceActivation(() => neuronOutput);
      // Forget gate
      longTermMemory = hiddenActivationComponent * longTermMemory;
      // Update gate
      longTermMemory = (hiddenActivationComponent * hiddenRecurrentComponent) +
          longTermMemory;
      // Output gate
      final stateRecurrentComponent =
          recurrenceActivation(() => longTermMemory);
      shortTermMemory = hiddenActivationComponent * stateRecurrentComponent;
      output.add(shortTermMemory);
    }

    return output;
  }
}
