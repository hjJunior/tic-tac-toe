import 'package:flutter/material.dart';
import 'package:tic_tac_toe/src/models/board.dart';

import 'package:tic_tac_toe/src/bloc/game_bloc.dart';

class Box extends StatelessWidget {
  Box(this.index, this.bloc, this.board);

  final int index;
  final GameBloc bloc;
  final Board board;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => bloc.selectPosition(index),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Color(0xFF262528),
        ),
        child: Center(
            child: Text(
              board.symbolFilledAt(index),
              style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
            )
        ),
      ),
    );
  }
}
