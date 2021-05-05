import 'package:synadart/src/activation.dart';
import 'package:synadart/src/layers/layer.dart';

/// `Layer` in which all `Neurons` are connected to all `Neurons` in the previous `Layer`
class LSTM extends Layer {
  /// Function used for LSTM activation
  late final ActivationFunction recurrentActivation;

  /// Memory carried across all `Neurons` inside the layer
  double longTermMemory = 1;
  /// Memory carried over from the current `Neuron` to the next `Neuron`
  double shortTermMemory = 1;

  /// Construct a LSTM layer
  /// 
  /// [size] - How many `Neurons` this `LSTM` has
  /// 
  /// [activation] - `ActivationAlgorithm` used for `Neuron` activation
  /// 
  /// [recurrentActivation] - `ActivationAlgorithm` used for `LSTM` activation
  LSTM({
    required int size,
    required ActivationAlgorithm activation,
    required ActivationAlgorithm recurrentActivation,
  }) : super(
    size: size,
    activation: activation,
  ) {
    this.recurrentActivation = resolveActivationAlgorithm(recurrentActivation);
  }

  /// Obtain the output by applying the recurrent memory algorithm
  @override
  List<double> get output {
    final List<double> output = [];

    for (final neuron in neurons) {
      double neuronOutput = neuron.output;
      double hiddenActivationComponent = neuron.activation(() => neuronOutput);
      double hiddenRecurrentComponent = recurrentActivation(() => neuronOutput);
      // Forget gate
      longTermMemory = hiddenActivationComponent * longTermMemory;
      // Update gate
      longTermMemory = (hiddenActivationComponent * hiddenRecurrentComponent) + longTermMemory;
      // Output gate
      double stateRecurrentComponent = recurrentActivation(() => longTermMemory);
      shortTermMemory = hiddenActivationComponent * stateRecurrentComponent;
      output.add(shortTermMemory);
    }

    return output;
  }
}