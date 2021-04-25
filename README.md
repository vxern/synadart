# synadart

The `synadart` library can be used to create neural networks of any complexity, as well as learn from the source code by studying its extremely clean implementation.

## Let's launch our first network

To begin using the `synadart`, you must first import it like so:

```dart
import 'package:synadart/synadart.dart';
```

Next, we must create a network of our chosen type. Let's create an MLP ( Multi-layer Perceptron ).

```dart
final mlp = MultilayerPerceptron(layerSizes: [15, 5, 1], activationAlgorithm: ActivationAlgorithm.logistic);
```