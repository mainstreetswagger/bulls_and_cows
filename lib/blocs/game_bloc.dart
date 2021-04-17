import 'dart:async';
import 'package:bulls_and_cows/mixins/game_mixin.dart';

class GameBloc extends Object with GameLogic {
  final _gameController = StreamController<String>.broadcast();
  Stream<String> get clientsNumber =>
      _gameController.stream.transform(gameStreamTransformer);
  Function(String) get changeClientsNumber => _gameController.sink.add;

  dispose() {
    _gameController.close();
  }
}

final bloc = GameBloc();
