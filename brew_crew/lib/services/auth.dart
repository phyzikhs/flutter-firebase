import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // sign in with anonymous
  Future signInAnon() async {
    try {
      UserCredential result = await _auth
          .signInAnonymously(); //AuthResult renamed to UserCredential
      FirebaseUser user = result.user;
      return user;
    } catch (e) {
      print('Could not load sign in');
      return null;
    }
  }

  // sign in with email

  // register with email

  // sign out

}
