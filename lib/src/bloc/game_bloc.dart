import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tic_tac_toe/src/models/board.dart';

class GameBloc {
  GameBloc(this.gameId, this.playerSymbol) {
    _userSelectorCtrl
      .stream
      .distinct()
      .where((_) => _board.nextPlayer == playerSymbol)
      .where((_) => !_board.hasWinner)
      .where((position) => !_board.isPositionFilled(position))
      .listen(_sendToFirebase);

    _board.resetBoard(Board.initialSequence);
  }

  Future<void> _sendToFirebase(int position) async {
    _board.fillPosition(position, playerSymbol);

    Firestore.instance.runTransaction((Transaction tx) async {
      await tx.update(tableRef, <String, dynamic>{
        'sequence': _board.sequences,
      });
    });
  }

  final String gameId;
  final String playerSymbol;
  final _board = Board();
  final _userSelectorCtrl = BehaviorSubject<int>()
    ..doOnListen(() => print('Listening'));


  DocumentReference get tableRef =>
    Firestore.instance.document('/games/$gameId');

  Function(int) get selectPosition => _userSelectorCtrl.sink.add;

  Stream<Board> get boardFirebase => Observable(tableRef.snapshots())
    .map((DocumentSnapshot document) {
      final data = (document.data['sequence'] as List).cast<String>();
      _board.resetBoard(data);
      return _board;
  });

  Stream<Board> get board => Observable.merge([
    boardFirebase,
    _userSelectorCtrl.stream.map((a) => _board)
  ]);

  Stream<String> get textStatus => Observable(board)
    .map((board) {
      if (board.hasWinner) {
        return 'PLAYER \'${board.winnerPlayer}\' WON';
      }

      if (board.draw) {
        return 'DRAW';
      }

      return 'NEXT PLAYER: ${board.nextPlayer}';
  });


  void dispose() {
    if (!_userSelectorCtrl.isClosed) _userSelectorCtrl.close();
  }
}