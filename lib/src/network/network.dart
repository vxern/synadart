import 'package:extended_math/extended_math.dart';
import 'package:neural_network/src/activation.dart';
import 'package:neural_network/src/layer.dart';

class Network {
  final List<Layer> layers;

  final num momentum;
  final num bias;
  final ActivationFunction activationFunction;

  Network({
    required int inputLayerNeuronCount,
    required List<int> hiddenLayerNeuronCounts,
    required int outputLayerNeuronCount,

    required this.momentum,
    required this.bias,
    required this.activationFunction,
  }) : layers = [
    Layer(
      neuronCount: inputLayerNeuronCount,
      parentNeuronCount: 0,
      momentum: momentum,
      bias: bias,
      activationFunction: activationFunction,
    ),
    ...List.generate(hiddenLayerNeuronCounts.length, (index) => Layer(
      neuronCount: hiddenLayerNeuronCounts[index],
      parentNeuronCount: index == 0 ? inputLayerNeuronCount : hiddenLayerNeuronCounts[index],
      momentum: momentum,
      bias: bias,
      activationFunction: activationFunction,
    )),
    Layer(
      neuronCount: outputLayerNeuronCount,
      parentNeuronCount: hiddenLayerNeuronCounts[hiddenLayerNeuronCounts.length - 1],
      momentum: momentum,
      bias: bias,
      activationFunction: activationFunction,
    )
  ];


}