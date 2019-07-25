import 'package:flutter/material.dart';
import 'package:tic_tac_toe/src/bloc/start_game_bloc.dart';
import 'package:tic_tac_toe/src/screens/game.dart';

class DialogConnectToGame extends StatefulWidget {
  @override
  _DialogConnectToGameState createState() => _DialogConnectToGameState();
}

class _DialogConnectToGameState extends State<DialogConnectToGame> {
  final bloc = StartGameBloc();

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text('Connect to existing game',),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text('To continue, please enter the room code to connect',),
        SizedBox(height: 10,),
        TextField(
          onChanged: bloc.setGameId,
          decoration: InputDecoration(
            hintText: 'Room code',
          ),
        ),
        SizedBox(height: 20,),
        StreamBuilder<bool>(
          stream: bloc.submitValid,
          initialData: false,
          builder: (context, snapshot) => RaisedButton(
            onPressed: (snapshot.data) ? connectToGame : null,
            color: Colors.yellow,
            child: Text('Connect'),
          ),
        )
      ],
    ),
    backgroundColor: Colors.white,
  );

  void connectToGame() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => GamePage(bloc.gameId, 'O'))
    );
  }
}