import 'package:flutter/foundation.dart';

class Board extends ChangeNotifier {
  Board() : _sequences = initialSequence;
  Board.fromSequence(this._sequences);

  static List<String> initialSequence = [
    '', '', '', '', '', '', '', '', ''
  ];

  List<String> _sequences;
  List<String> get positions => _sequences;

  bool isPositionFilled(int index) =>
    symbolFilledAt(index) != '';

  String symbolFilledAt(int index) =>
    _sequences.elementAt(index) ?? null;

  void fillPosition(int index, String playerSymbol) {
    _sequences[index] = playerSymbol;
    notifyListeners();
  }

  void resetBoard(List<String> newSequence) {
    if (newSequence.isNotEmpty) {
      _sequences = newSequence;
    }
  }

  String get nextPlayer {
    final countPlaysSymbolX = _sequences.where((box) => box == 'X').length;
    final countPlaysSymbolY = _sequences.where((box) => box == 'O').length;

    if (countPlaysSymbolX > countPlaysSymbolY) {
      return 'O';
    }

    return 'X';
  }

  bool get draw => !_sequences.contains('');

  bool get hasWinner => checkIfPlayerWon('X') || checkIfPlayerWon('O');

  String get winnerPlayer => checkIfPlayerWon('X') ? 'X' : 'O';

  bool checkIfPlayerWon(String symbol) {
    final winningSequences = [
      [0,1,2],
      [3,4,5],
      [6,7,8],
      [0,3,6],
      [1,4,7],
      [2,5,8],
      [0,4,8],
      [2,4,6]
    ];

    return winningSequences.any(
      (winningSequence) =>
        winningSequence.fold(
          true,
          (lastCheck, field) =>
            lastCheck && _sequences[field] == symbol
      )
    );
  }

  List get sequences => _sequences;
}