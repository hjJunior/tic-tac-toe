import 'package:flutter/material.dart';

class GameOver extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54.withAlpha(20),
      padding: EdgeInsets.symmetric(vertical: 50, horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("GAME OVER", style: TextStyle(fontSize: 45, color: Colors.yellow, fontFamily: 'Crackman'),),
          SizedBox(height: 10,),
          RaisedButton(
            onPressed: () => print('Hello?'),
            child: Text('Play Again'),
          )
        ],
      ),
    );
  }
}