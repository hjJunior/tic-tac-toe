import 'package:rxdart/rxdart.dart';

class StartGameBloc {
  final _gameIdInputCtrl = BehaviorSubject<String>();

  Function(String) get setGameId => _gameIdInputCtrl.sink.add;
  String get gameId => _gameIdInputCtrl.value;
  Stream<bool> get submitValid => _gameIdInputCtrl
    .stream
    .map((code) => code.isNotEmpty);

  void dispose() {
    if (!_gameIdInputCtrl.isClosed)
      _gameIdInputCtrl.close();
  }
}
