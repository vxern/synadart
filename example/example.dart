import 'package:synadart/src/layers/core/dense.dart';
import 'package:synadart/synadart.dart';

void main() {
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
      ),
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

  // Training data contains different number patterns.
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

  // Test data which contains distorted patterns of the number 5.
  final testData = [
    '111100111000111'.split('').map(double.parse).toList(),
    '111100010001111'.split('').map(double.parse).toList(),
    '111100011001111'.split('').map(double.parse).toList(),
    '110100111001111'.split('').map(double.parse).toList(),
    '110100111001011'.split('').map(double.parse).toList(),
    '111100101001111'.split('').map(double.parse).toList(),
  ];

  // The number 5 itself.
  final numberFive = trainingData[5];

  // Train the network using the training and expected data.
  network.train(inputs: trainingData, expected: expected, iterations: 20000);

  print('Confidence in recognising a 5: ${network.process(numberFive)}');
  for (final test in testData) {
    print('Confidence in recognising a distorted 5: ${network.process(test)}');
  }
  print('Is 0 a 5? ${network.process(trainingData[0])}');
  print('Is 8 a 5? ${network.process(trainingData[8])}');
  print('Is 3 a 5? ${network.process(trainingData[3])}');
}
