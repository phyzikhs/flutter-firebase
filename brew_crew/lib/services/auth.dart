import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // sign in with anonymous
  Future signInAnon() async {
    try {
      //AuthResult renamed to UserCredential
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user; // FirebaseUser deprecated, use auh.User
      return user;
    } catch (e) {
      print('Could not load sign in: $e');
      return null;
    }
  }

  // sign in with email

  // register with email

  // sign out

}
