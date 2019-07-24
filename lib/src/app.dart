import 'package:flutter/material.dart';
import 'package:tic_tac_toe/src/screens/start_game.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      debugShowCheckedModeBanner: false,
      home: StartGame(),
    );
  }
}