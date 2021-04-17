import 'package:neural_network/src/activation.dart';
import 'package:neural_network/src/neuron.dart';

/// A neural layer consisting of two or more neurons
class Layer {
  final List<Neuron> neurons;

  const Layer({this.neurons = const []});

  factory Layer.create({
    required int size,
    required int parentNeuronCount,

    required num momentum,
    required num bias,
    required ActivationFunction activationFunction,
  }) => Layer(
    neurons: List.generate(size, (_) => Neuron(
      parentNeuronCount: parentNeuronCount,
      momentum: momentum,
      bias: bias,
      activationFunction: activationFunction,
    ))
  );
}