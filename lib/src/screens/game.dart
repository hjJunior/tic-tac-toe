import 'package:flutter/material.dart';
import 'package:tic_tac_toe/src/bloc/game_bloc.dart';
import 'package:tic_tac_toe/src/styles/colors.dart';
import 'package:tic_tac_toe/src/styles/text.dart';
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
      backgroundColor: AppColors.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          BrandText('TIC TAC TOE'),
          StreamBuilder<String>(
            initialData: 'LOADING...',
            stream:  bloc.textStatus,
            builder: (context, snapshot) => Text(
              snapshot.data,
              style: AppTextStyle.textBody1,
            ),
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