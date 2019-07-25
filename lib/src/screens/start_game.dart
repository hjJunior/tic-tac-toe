import 'package:flutter/material.dart';
import 'package:tic_tac_toe/src/bloc/new_game_bloc.dart';
import 'package:tic_tac_toe/src/dialogs/connect_to_game.dart';
import 'package:tic_tac_toe/src/dialogs/new_game.dart';
import 'package:tic_tac_toe/src/styles/colors.dart';
import 'package:tic_tac_toe/src/widgets/brand_text.dart';
import 'package:tic_tac_toe/src/widgets/menu_item.dart';

class StartGame extends StatelessWidget {
  void showModal(BuildContext context, bool newGame) {
    final bloc = NewGameBloc();

    showDialog(
        context: context,
        builder: (_) => newGame
          ? DialogNewGame(bloc)
          : DialogConnectToGame()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(height: 12,),
              BrandText('TIC TAC TOE'),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                MenuItem(
                  menuText: 'New Game',
                  onClick: () => showModal(context, true),
                ),
                MenuItem(
                  menuText: 'Connect to existing game',
                  onClick: () => showModal(context, false),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}