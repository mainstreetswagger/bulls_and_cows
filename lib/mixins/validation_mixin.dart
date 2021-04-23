import 'package:bulls_and_cows/mixins/game_mixin.dart';

class ValidationMixin {
  static String validateFourDigit(String value) {
    if (int.tryParse(value) == null) {
      return 'it is not a number';
    } else if (value.length != 4) {
      return 'must be four digit number';
    } else if (GameLogic.convertToListOfInts(value).toSet().length < 4) {
      return 'no repeatable numbers';
    } else {
      return 'ok';
    }
  }
}
