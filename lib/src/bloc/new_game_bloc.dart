import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tic_tac_toe/src/models/board.dart';

class NewGameBloc {
  final _firebaseCtrl = BehaviorSubject<DocumentReference>();
  String get game => _firebaseCtrl.value.documentID;

  Stream<String> get gameId => _firebaseCtrl
    .map((reference) => reference.documentID);

  Future<DocumentReference> pushNewGameToFirebase() =>
    Firestore.instance.collection('games').add(<String, dynamic>{
      'sequence': Board.initialSequence
    });

  Future<void> createGame() async {
    print('createGame');
    _firebaseCtrl.add(await pushNewGameToFirebase());
  }

  void dispose() {
    if (!_firebaseCtrl.isClosed) _firebaseCtrl.close();
  }
}
