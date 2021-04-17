class ValidationMixin {
  static String validateFourDigit(String value) {
    if (int.tryParse(value) == null) {
      return 'it is not a number';
    } else if (value.length != 4) {
      return 'must be four digit number';
    } else {}
    return 'ok';
  }
}
