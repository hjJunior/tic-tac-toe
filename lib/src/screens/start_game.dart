import 'package:flutter/material.dart';
import 'package:tic_tac_toe/src/bloc/new_game_bloc.dart';
import 'package:tic_tac_toe/src/dialogs/connect_to_game.dart';
import 'package:tic_tac_toe/src/dialogs/new_game.dart';
import 'package:tic_tac_toe/src/widgets/brand_text.dart';

class StartGame extends StatelessWidget {
  void showModal(BuildContext context, bool newGame) {
    final bloc = NewGameBloc();

    showDialog(
        context: context,
        builder: (_) => newGame ? DialogNewGame(bloc) : DialogConnectToGame()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1f1e1f),
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
                GestureDetector(
                  onTap: () => showModal(context, true),
                  child: Container(
                    color: Colors.yellow,
                    padding: EdgeInsets.all(20),
                    child: Text('New Game'.toUpperCase(), style: TextStyle(color: Colors.black,),),
                  ),
                ),
                GestureDetector(
                  onTap: () => showModal(context, false),
                  child: Container(
                    color: Colors.yellow,
                    padding: EdgeInsets.all(20),
                    child: Text('Connect to existing game'.toUpperCase(), style: TextStyle(color: Colors.black,),),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}