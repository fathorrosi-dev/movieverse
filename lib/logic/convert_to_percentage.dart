String convertToPercentage(double value) {
  if (value < 0.0) {
    value = 0.0;
  } else if (value > 10.0) {
    value = 10.0;
  }

  final percentage = (value / 10.0) * 100;
  final percentageString = '${percentage.toStringAsFixed(0)}%';
  return percentageString;
}
