import 'package:brew_crew/models/user_bc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create UserBC object based on firebase User
  UserBC _userBCFromFirebaseUser(User user) {
    return (user == null) ? null : UserBC(uid: user.uid);
  }

  // auth change user stream
  Stream<UserBC> get user {
    return _auth
        .authStateChanges()
        // .map((User user) => _userBCFromFirebaseUser(user));
        .map(_userBCFromFirebaseUser); // same thing
  }

  // sign in with anonymous
  Future signInAnon() async {
    try {
      //AuthResult renamed to UserCredential
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user; // FirebaseUser deprecated, use auh.User
      return _userBCFromFirebaseUser(user);
    } catch (e) {
      print('Could not load sign in: $e');
      return null;
    }
  }

  // sign in with email

  // register with email & password
  Future registerWithEmailPassword(String email, String password) async {
    try {
      //AuthResult renamed to UserCredential
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user; // FirebaseUser deprecated, use auh.User
      return _userBCFromFirebaseUser(user);
    } catch (e) {
      print('Could not register user: $e');
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print('Could not sign out: $e');
      return null;
    }
  }
}
