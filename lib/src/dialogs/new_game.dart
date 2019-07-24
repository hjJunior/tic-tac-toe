import 'package:flutter/material.dart';
import 'package:tic_tac_toe/src/bloc/new_game_bloc.dart';
import 'package:tic_tac_toe/src/screens/game.dart';
import 'package:tic_tac_toe/src/widgets/qrcode.dart';

class DialogNewGame extends StatefulWidget {
  DialogNewGame(this.bloc);
  final NewGameBloc bloc;

  @override
  _DialogNewGameState createState() => _DialogNewGameState();
}

class _DialogNewGameState extends State<DialogNewGame> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('New Game',),
      content: Column(
        children: <Widget>[
          SizedBox(height: 10,),
          StreamBuilder(
            stream: widget.bloc.gameId,
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                if (!snapshot.hasData) {
                  widget.bloc.createGame();
                }

                return Column(
                  children: <Widget>[
                    CircularProgressIndicator(),
                    SizedBox(height: 20,),
                    Text('Creating new game...',),
                  ],
                );
              }

              return Column(
                children: <Widget>[
                  Text('Share this code with your friends to play together'),
                  SizedBox(height: 20,),
                  QrCode(snapshot.data),
                  TextFormField(
                    initialValue: snapshot.data,
                    enabled: false,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20,),
                  RaisedButton(
                    onPressed: startGame,
                    color: Colors.yellow,
                    child: Text('Continue'),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }

  void startGame() async {
    final gameId = widget.bloc.game;

    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => GamePage(gameId, 'X'))
    );

    Navigator.of(context).pop();
  }
}

