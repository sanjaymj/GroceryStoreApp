import 'package:dinci_samaan/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _createUserFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(user.uid): null;

  }

  Future signInAnonymously() async {
    try{
      FirebaseUser user = await _auth.signInAnonymously();
      return _createUserFromFirebaseUser(user);
    } catch (e) {
      return null;
    }
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map((FirebaseUser user) => _createUserFromFirebaseUser(user));
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }

  Future registerWithEmailAndPassword(String email, String password) async{
    try {
      FirebaseUser user = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return _createUserFromFirebaseUser(user);
    } catch (e) {
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async{
    try {
      FirebaseUser user = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return _createUserFromFirebaseUser(user);
    } catch (e) {
      return null;
    }
  }
}