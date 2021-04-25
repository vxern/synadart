import 'package:synadart/synadart.dart';

void main() {
  final mlp = MultilayerPerceptron(layerSizes: [15, 5, 1], activationAlgorithm: ActivationAlgorithm.sigmoid);

  final expected = [[0.0],[0.0],[0.0],[0.0],[0.0],[1.0],[0.0],[0.0],[0.0],[0.0]];

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

  final tests = [
    '111100111000111'.split('').map(double.parse).toList(),
    '111100010001111'.split('').map(double.parse).toList(),
    '111100011001111'.split('').map(double.parse).toList(),
    '110100111001111'.split('').map(double.parse).toList(),
    '110100111001011'.split('').map(double.parse).toList(),
    '111100101001111'.split('').map(double.parse).toList(),
  ];

  final numberFive = '111100111001111'.split('').map(double.parse).toList();

  mlp.train(input: trainingData, expected: expected, iterations: 5000);

  print('Confidence in recognising a 5: ${mlp.process(numberFive)}');
  for (final test in tests) {
    print('Confidence in recognising a distorted 5: ${mlp.process(test)}');
  }
  print('Is 0 a 5? ${mlp.process(trainingData[0])}');
  print('Is 8 a 5? ${mlp.process(trainingData[8])}');
  print('Is 3 a 5? ${mlp.process(trainingData[3])}');
}