double truncateDouble(double val, int decimals) {
  String valString = val.toString();
  int dotIndex = valString.indexOf('.');

  // not enough decimals
  int totalDecimals = valString.length - dotIndex - 1;
  if (totalDecimals < decimals) {
    decimals = totalDecimals;
  }

  valString = valString.substring(0, dotIndex + decimals + 1);

  return double.parse(valString);
}