import 'dart:io';

/// Raw representation of a single `Neuron` as a Json Map.
typedef RawNeuron = Map<String, dynamic>;

/// Writes a string to a file.
Future<void> writeToFile(String absolutePath, String data) async {
  final file = File(absolutePath);
  await file.writeAsString(data);
}

/// Reads a string from a file.
Future<String> readFromFile(String absolutePath) async {
  try {
    final file = File(absolutePath);
    return await file.readAsString();
  } on Exception catch (e) {
    print('Error reading file: $e');
    rethrow;
  }
}
