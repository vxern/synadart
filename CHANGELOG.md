# Version 0.1.0

- Added Multi-layer Perceptron and a basic algorithm for backpropagation

# Version 0.1.1

- Added README.md, updated formatting

# Version 0.2.0

- Added FF ( feedforward ) and simple Perceptron networks
- Added LReLU, eLU and tanh activation function
- Renamed 'sigmoid' to 'logistic' function

# Version 0.2.1

- Removed FF ( feedforward ) and simple Perceptron networks in favour of an upcoming simpler implementation of basically the same idea, through just one network model.
- Added [learningRate] as a parameter, and removed the hard-coded value of 0.2.
- Organised the files slightly
- Updated documentation of `Neuron`

# Version 0.2.2

- Updated documentation of `Layer` and removed a chunk of dead code.

# Version 0.2.3

- Updated documentation of `Network`.
- Replaced `process()` in `Layer` with an `output` getter, simplifying the implementation of getting each `Neuron`'s output.

# Version 0.2.4

- Updated documentation of `activation.dart`, having added explanations for the different activation functions.

# Version 0.2.5

- Renamed `Multilayer Perceptron` to `Deep Feed-forward`, which should be a more fitting and future-proof name.

# Version 0.3.0

- Updated documentation of `Logger`, `Backpropagation` and `ValueGenerator`.
- Created `examples` folder with a `recognise_5` example that allows for recognition of the number '5'.

# Version 0.3.1

- Added 5 new activation functions: `SeLU`, `Softplus`, `Softsign`, `Swish` and `Gaussian`.
- Renamed the `logistic` function to `sigmoid`.
- Added `abs` function for obtaining the absolute of a value to `mathematical_operations`.

# Version 0.3.2

- Added simple feed-forward network model.

# Version 0.4.0

- Code organisation.
- Replacing network types such as `feed-forward` or `deep feed-forward` with a simple `Sequential`.
- Moved focus from `Network` to `Layer`, so that different layers can be added to a `Network`, rather than creating new types of networks, and limiting the user to a preset model.
- Updated example code and README.md

# Version 0.4.1

- Updated documentation

# Version 0.4.1+1

- Refactoring code
- Removing `logger.dart` in favour of `Sprint`