import 'package:synadart/src/layers/core/dense.dart';
import 'package:synadart/synadart.dart';

const modelPath = r'C:\Users\myName\Documents\myModel.json';

final trainingData = [
  '111101101101111'.split('').map(double.parse).toList(),
  '001001001001001'.split('').map(double.parse).toList(),
  '111001111100111'.split('').map(double.parse).toList(),
  '111001111001111'.split('').map(double.parse).toList(),
  '101101111001001'.split('').map(double.parse).toList(),
  '111100111001111'.split('').map(double.parse).toList(), // 5
  '111100111101111'.split('').map(double.parse).toList(),
  '111001001001001'.split('').map(double.parse).toList(),
  '111101111101111'.split('').map(double.parse).toList(),
  '111101111001111'.split('').map(double.parse).toList(),
];

void main() {
  _train().then((value) => _load());
}

Future<void> _load() async {
  // Load the model from the file.
  final network = await Sequential.loadModel(modelPath);

  // The number 5 itself.
  final numberFive = trainingData[5];

  // Use the model.
  final result = network.process(numberFive);
  print('Confidence in recognising a 5: $result');
}

Future<void> _train() async {
  final network = Sequential(
    learningRate: 0.2,
    layers: [
      Dense(
        size: 15,
        activation: ActivationAlgorithm.sigmoid,
      ),
      Dense(
        size: 5,
        activation: ActivationAlgorithm.sigmoid,
      ),
      Dense(
        size: 1,
        activation: ActivationAlgorithm.sigmoid,
      )
    ],
  );

  // We are expecting to get the number '5'.
  final expected = [
    [0.01], // 0
    [0.01], // 1
    [0.01], // 2
    [0.01], // 3
    [0.01], // 4
    [0.99], // 5
    [0.01], // 6
    [0.01], // 7
    [0.01], // 8
    [0.01], // 9
  ];

  // The number 5 itself.
  final numberFive = trainingData[5];

  // Train the network using the training and expected data.
  network.train(inputs: trainingData, expected: expected, iterations: 20000);

  final result = network.process(numberFive);
  print('Confidence in recognising a 5: $result');

  // Save the model to the file.
  await network.saveModel(modelPath);
  print('Model saved to $modelPath');
}
