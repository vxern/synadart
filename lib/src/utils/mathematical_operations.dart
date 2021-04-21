/// Calculates the dot product of two lists
double dot(List<double> a, List<double> b) {
  double result = 0;
  for (int index = 0; index < a.length; index++) {
    result += a[index] * b[index];
  }
  return result;
}

/// Subtracts list [b] from list [a]
List<double> subtract(List<double> a, List<double> b) {
  List<double> result = const [];
  for (int index = 0; index < a.length; index++) {
    result.add(a[index] - b[index]);
  }
  return result;
}