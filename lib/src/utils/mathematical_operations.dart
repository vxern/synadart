/// Calculates the dot product of two lists
double dot(List<double> a, List<double> b) {
  double result = 0;
  for (int index = 0; index < a.length; index++) {
    result += a[index] * b[index];
  }
  return result;
}

/// Adds values in list [b] to list [a]
List<double> add(List<double> a, List<double> b) {
  final List<double> result = [];
  for (int index = 0; index < a.length; index++) {
    result.add(a[index] + b[index]);
  }
  return result;
}

/// Subtracts values in list [b] from list [a]
List<double> subtract(List<double> a, List<double> b) {
  final List<double> result = [];
  for (int index = 0; index < a.length; index++) {
    result.add(a[index] - b[index]);
  }
  return result;
}