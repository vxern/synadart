double dot(List<double> a, List<double> b) {
  double result = 0;
  for (int index = 0; index < a.length; index++) {
    result += a[index] * b[index];
  }
  return result;
}