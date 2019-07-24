import 'package:flutter/material.dart';
import 'package:tic_tac_toe/src/bloc/game_bloc.dart';
import 'package:tic_tac_toe/src/widgets/board_grid.dart';
import 'package:tic_tac_toe/src/widgets/brand_text.dart';

class GamePage extends StatelessWidget {
  GamePage(this.gameId, this.playerSymbol);
  final String gameId;
  final String playerSymbol;

  @override
  Widget build(BuildContext context) {
    final bloc = GameBloc(gameId, playerSymbol);

    return Scaffold(
      backgroundColor: Color(0xFF1f1e1f),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          BrandText('TIC TAC TOE'),
          StreamBuilder<String>(
            initialData: 'LOADING...',
            stream:  bloc.textStatus,
            builder: (context, snapshot) {
              return Text(snapshot.data, style: TextStyle(fontSize: 21, color: Colors.white),);
            }
          ),
          Container(
              height: 450,
              child: BoardGrid(bloc)
          ),
        ],
      ),
    );
  }
}