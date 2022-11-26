import 'dart:convert';

import 'package:synadart/src/layers/core/dense.dart';
import 'package:synadart/src/networks/network.dart';
import 'package:synadart/src/networks/training/backpropagation.dart';
import 'package:synadart/src/neurons/neuron.dart';
import 'package:synadart/src/utils/save_load.dart';
import 'package:synadart/synadart.dart';

/// A `Network` model in which every `Layer` has one input and one output
/// tensor.
class Sequential extends Network with Backpropagation {
  final String _activationField = 'activation';
  final String _neuronsField = 'neurons';

  /// Creates a `Sequential` model network.
  Sequential({
    required super.learningRate,
    super.layers,
  });

  /// Load the model from a JSON file.
  static Future<Sequential> loadModel(String absolutePath) async {
    final jsonData = await readFromFile(absolutePath);
    return Sequential._loadModel(jsonData);
  }

  /// Loads a model from a JSON string.
  Sequential._loadModel(String rawNeuronData)
      : super(
          layers: [],
          learningRate: 0,
        ) {
    final data = jsonDecode(rawNeuronData) as List;
    for (final layer in data) {
      final activationIndex = layer[_activationField] as int;
      final neuronsInfo = List<RawNeuron>.from(layer[_neuronsField] as List);

      final activation = ActivationAlgorithm.values[activationIndex];
      final neurons = neuronsInfo.map(Neuron.fromJson);

      final denseLayer = Dense(
        size: neurons.length,
        activation: activation,
      )
        // Only the firt layer is an input layer
        ..isInput = layers.isEmpty
        ..neurons.addAll(neurons);

      layers.add(denseLayer);
    }
  }

  /// Save the model to a JSON file.
  Future<void> saveModel(String path) async {
    // Save weights and biases for each neuron in each layer
    final data = <Map<String, dynamic>>[];
    for (final layer in layers) {
      final neuronData = <Map>[];
      for (final neuron in layer.neurons) {
        neuronData.add(neuron.toJson());
      }
      final layerData = <String, dynamic>{
        _activationField: layer.activation.index,
        _neuronsField: neuronData,
      };
      data.add(layerData);
    }
    final jsonData = jsonEncode(data);
    await writeToFile(path, jsonData);
  }
}
