import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tic_tac_toe/src/models/board.dart';

class GameBloc {
  GameBloc(this.gameId, this.playerSymbol) {
    setupUserSelectorCtrlStream();
    _board.resetBoard(Board.initialSequence);
  }

  final String gameId;
  final String playerSymbol;
  final _board = Board();
  final _userSelectorCtrl = BehaviorSubject<int>();

  DocumentReference get tableRef =>
    Firestore.instance.document('/games/$gameId');

  Function(int) get selectPosition => _userSelectorCtrl.sink.add;

  Stream<Board> get remoteBoard => Observable(tableRef.snapshots())
    .map(mapAndSyncFromRemoteBoard);

  Stream<Board> get board => Observable.merge([
    remoteBoard,
    _userSelectorCtrl.stream.map((a) => _board)
  ]);

  Stream<String> get textStatus => Observable(board).map((board) {
    if (board.hasWinner) {
      return 'PLAYER \'${board.winnerPlayer}\' WON';
    }

    if (board.draw) {
      return 'DRAW';
    }

    return 'NEXT PLAYER: ${board.nextPlayer}';
  });

  void setupUserSelectorCtrlStream() {
    _userSelectorCtrl
      .stream
      .distinct()
      .where((_) => _board.nextPlayer == playerSymbol)
      .where((_) => !_board.hasWinner)
      .where((position) => !_board.isPositionFilled(position))
      .listen(_syncBoardFields);
  }

  Future<void> _syncBoardFields(int position) async {
    _board.fillPosition(position, playerSymbol);

    Firestore.instance.runTransaction((Transaction tx) async {
      await tx.update(tableRef, <String, dynamic>{
        'sequence': _board.sequences,
      });
    });
  }

  Board mapAndSyncFromRemoteBoard(DocumentSnapshot document) {
    final data = (document.data['sequence'] as List).cast<String>();
    _board.resetBoard(data);
    return _board;
  }

  void dispose() {
    if (!_userSelectorCtrl.isClosed) _userSelectorCtrl.close();
  }
}