import 'package:flutter/material.dart';
import 'package:tic_tac_toe/src/bloc/game_bloc.dart';
import 'package:tic_tac_toe/src/models/board.dart';
import 'package:tic_tac_toe/src/widgets/box.dart';

class BoardGrid extends StatelessWidget {
  BoardGrid(this.bloc);

  final GameBloc bloc;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Board>(
        initialData: Board(),
        stream: bloc.board,
        builder: (context, snapshot) {
          final board = snapshot.data;

          if (snapshot.hasError) {
            return Text('Error ${snapshot.error}');
          }

          if (!snapshot.hasData) {
            bloc.boardFirebase.listen(print);
            return Text('No info');
          }


          return Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 30),
                child: GridView.builder(
                  padding: EdgeInsets.all(10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 6
                  ),
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (_, index) {
                    return Box(index, bloc, board);
                  },
                  itemCount: 9,
                ),
              ),
            ],
          );
        }
    );
  }
}
