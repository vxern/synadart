# 0.4.3

- Bumped version of `sprint` from `1.0.2+3` to `1.0.3`.
- Updated repository, homepage and issue tracker links.
- Refactored and made formatting and style changes to bring the project up to
  par.

# 0.4.2+1

- Updated package description.

# 0.4.2

- Updated `sprint` version from `1.0.0+1` to `1.0.2+3`.
- Replaced the now discontinued `pedantic` with the `words` lint ruleset.
- Reversed the order of versions in `CHANGELOG.md` from ascending to descending.

# 0.4.1+1

- Refactored code.
- Removed `logger.dart` in favour of the `sprint` package.

# 0.4.1

- Updated documentation.

# 0.4.0

- Organised code.
- Replaced network types such as `feed-forward` or `deep feed-forward` with a
  single class `Sequential`.
- Moved focus from `Network` to `Layer`, so that different layers can be added
  to a `Network`, rather than creating new types of networks, and limiting the
  user to a preset model.
- Updated `example.dart` and `README.md`.

# 0.3.2

- Added a simple feed-forward network model.

# 0.3.1

- Added 5 new activation functions: `SeLU`, `Softplus`, `Softsign`, `Swish` and
  `Gaussian`.
- Renamed the 'logistic' function to 'sigmoid'.
- Created function `abs()` for obtaining the absolute value of a variable.

# 0.3.0

- Updated documentation of `Logger`, `Backpropagation` and `ValueGenerator`.
- Created `/examples` directory with a file `example.dart` that displays the
  network being used to recognise the number '5'.

# Version 0.2.5

- Renamed 'Multilayer Perceptron' to 'Deep Feed-Forward', since 'deep
  feed-forward' is broader as a concept than 'multi-layer perceptrons'.

# Version 0.2.4

- Updated documentation of `activation.dart`, having added explanations for the
  different activation functions.

# Version 0.2.3

- Updated documentation of `Network`.
- Replaced `process()` in `Layer` with an `output` getter, simplifying the
  method of getting each `Neuron`'s output.

# Version 0.2.2

- Updated documentation of `Layer` and removed a chunk of dead code.

# Version 0.2.1

- Removed the feed-forward network and simple perceptrons in favour of an
  upcoming simpler implementation of networks, through the use of a single
  network model.
- Added [learningRate] as a parameter, and removed the hard-coded value of
  `0.2`.
- Updated documentation of `Neuron`.

# Version 0.2.0

- Added a feed-forward network and simple perceptrons.
- Added `LReLU`, `eLU` and `tanh` activation functions.
- Renamed 'sigmoid' to 'logistic'.

# Version 0.1.1

- Added `README.md` and updated formatting.

# Version 0.1.0

- Implemented a multilayer perceptron and a basic algorithm for backpropagation.
