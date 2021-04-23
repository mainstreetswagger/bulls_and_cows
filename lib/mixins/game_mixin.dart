import 'dart:math';
import 'dart:async';
import 'package:bulls_and_cows/mixins/validation_mixin.dart';

class GameLogic {
  static Map<String, int> matches = Map<String, int>();
  static List<int> _secretNumber = [];
  static int _length = 4;
  static String _bulls = 'bulls';
  static String _cows = 'cows';
  static String _result;

  // final refreshGame =
  //     StreamTransformer.fromHandlers(handleDone: (EventSink<String> sink) {
  //   getRandom(_length);
  //   sink.add('game refreshed');
  // });

  final gameStreamTransformer = StreamTransformer.fromHandlers(
      handleData: (String clientValue, EventSink<String> sink) {
    String validationResult = ValidationMixin.validateFourDigit(clientValue);
    if (validationResult == 'ok') {
      if (_secretNumber.length == 0) {
        getRandom(_length);
      }
      List<int> guessNumber = convertToListOfInts(clientValue);
      Map<String, int> matches = checkBullsAndCows(guessNumber);
      print(matches);
      if (matches[_bulls] == _length) {
        sink.add('You won!');
      } else {
        _result =
            'you entered: $clientValue. matches => bulls: ${matches[_bulls]}, cows: ${matches[_cows]}';
        sink.add(_result);
      }
    } else {
      sink.addError(validationResult);
    }
  });

  static List<int> getRandom(int length) {
    _secretNumber.length = length;
    int number;
    for (int i = 0; i < length; i++) {
      number = Random().nextInt(10);
      while (_secretNumber.indexWhere((element) => element == number) != -1) {
        number = Random().nextInt(10);
      }
      _secretNumber[i] = number;
    }
    print(_secretNumber);
    return _secretNumber;
  }

  static List<int> convertToListOfInts(String number) {
    return number.split('').map((e) => int.parse(e)).toList();
  }

  static Map<String, int> checkBullsAndCows(List<int> guessNumber) {
    int bulls = 0;
    int cows = 0;
    if (_secretNumber != null && _secretNumber.length == guessNumber.length) {
      for (int i = 0; i < _secretNumber.length; i++) {
        if (_secretNumber.contains(guessNumber[i])) {
          if (_secretNumber[i] == guessNumber[i]) {
            bulls++;
          } else {
            cows++;
          }
        }
      }
      matches[_bulls] = bulls;
      matches[_cows] = cows;
      return matches;
    } else {
      throw new Exception('first call getRandom()');
    }
  }

  List<int> get getSecretNumber {
    return _secretNumber;
  }
}
