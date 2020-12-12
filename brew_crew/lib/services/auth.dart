import 'dart:developer';

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

  // register with email

  // sign out

}
