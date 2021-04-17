import 'package:extended_math/extended_math.dart';

class Activation {
  static num Function() resolveFunction(
    ActivationFunction activationFunction,
    {required num momentum, required num weightedSum}
  ) {
    switch (activationFunction) {
      case ActivationFunction.Sigmoid:
        return () => 1 / (1 + pow(e, -(momentum * weightedSum)));
      case ActivationFunction.ReLU:
        return () => max(0, weightedSum);
    }
  }
}

enum ActivationFunction {
  Sigmoid,
  ReLU
}