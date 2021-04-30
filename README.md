# synadart

The `synadart` library can be used to create neural networks of any complexity, as well as learn from the source code by studying its extremely clean implementation.

## Launching our first network

To begin using the `synadart`, we must first import it into our project:

```dart
import 'package:synadart/synadart.dart';
```

Next, we must create a network of our chosen type. Let's create a sequential network, in which every layer has one input and one output tensor. This should be pretty easy:

```dart
final network = Sequential(learningRate: 0.3);
```

Our network is currently empty; it contains no layers and therefore no neurons. Let's add three layers; the input layer, one hidden layer and the output layer:

```dart
network.addLayers([
    Dense(15, activationAlgorithm: ActivationAlgorithm.sigmoid),
    Dense(5, activationAlgorithm: ActivationAlgorithm.sigmoid),
    Dense(1, activationAlgorithm: ActivationAlgorithm.sigmoid),
]);
```

Now that our network has some structure to it, we can begin using it.. No, not quite yet. Our network is still not trained, and has no clue what it is doing. Time to train it.

Firstly, we will create a list of *expected* values, i.e. *values we are expecting the network to output*. Here, we are expecting to get the number '5'.

```dart
final expected = [
  [0.01], // 0
  [0.01], // 1
  [0.01], // 2
  [0.01], // 3
  [0.01], // 4
  [0.99], // 5 ( This is what we are anticipating )
  [0.01], // 6
  [0.01], // 7
  [0.01], // 8
  [0.01], // 9
];
```

Fantastic, we are now expecting our infantile network to magically output a number 5, not having taught it a thing. Oh, right - that's where the training data part comes in!

We must now tell the network what each of our expected output values is associated with. Let's teach it some numbers:

```dart
final trainingData = [
  '111101101101111'.split('').map(double.parse).toList(), // Pixel representation of a 0,
  '001001001001001'.split('').map(double.parse).toList(), // a 1,
  '111001111100111'.split('').map(double.parse).toList(), // a 2,
  '111001111001111'.split('').map(double.parse).toList(), // a 3,
  '101101111001001'.split('').map(double.parse).toList(), // a 4,
  '111100111001111'.split('').map(double.parse).toList(), // a 5,
  '111100111101111'.split('').map(double.parse).toList(), // a 6,
  '111001001001001'.split('').map(double.parse).toList(), // a 7,
  '111101111101111'.split('').map(double.parse).toList(), // an 8,
  '111101111001111'.split('').map(double.parse).toList(), // and a 9.
];
```

Now that we granted our network a grand total of 10 numbers to learn, we can begin training the network using the values we've set up:

```dart
network.train(inputs: trainingData, expected: expected, iterations: 5000);
```

Wonderful! We've trained our network using the pixel representation of number images, and our network is now able to recognise the number '5' with relative confidence. The last step is to test our network's capabilities ourselves.

Let's give our network a couple pixel representations of distorted images of the number '5':

```dart
final testData = [
  '111100111000111'.split('').map(double.parse).toList(),
  '111100010001111'.split('').map(double.parse).toList(),
  '111100011001111'.split('').map(double.parse).toList(),
  '110100111001111'.split('').map(double.parse).toList(),
  '110100111001011'.split('').map(double.parse).toList(),
  '111100101001111'.split('').map(double.parse).toList(),
];
```

To check the confidence of the network in recognising distorted '5's:

```dart
for (final test in testData) {
  print('Confidence in recognising a distorted 5: ${network.process(test)}');
}
```