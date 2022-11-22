class FixedNumber {
  static String getFixedNumber(num number, {int fixedValue = 2}) {
    String fixedNumber = number.toStringAsFixed(fixedValue);
    int fractureIndex = fixedNumber.indexOf('.');
    String floatingSide = fixedNumber.substring(fractureIndex);
    String zeroes = floatingSide.replaceAll(RegExp('[0-9]'), '0');
    if (zeroes == floatingSide) {
      return fixedNumber.substring(0, fractureIndex);
    } else {
      return fixedNumber;
    }
  }
}
