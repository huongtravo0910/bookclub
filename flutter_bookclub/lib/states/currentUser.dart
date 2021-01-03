import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CurrentUser extends ChangeNotifier {
  String _uid;
  String _email;

  String get uid => _uid;
  String get email => _email;

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> onStartUp() async {
    String retVal = "error";

    try {
      User _user = await _auth.currentUser;
      _uid = _user.uid;
      _email = _user.email;
      retVal = "success";
    } catch (e) {
      debugPrint(e.toString());
    }
    return retVal;
  }

  Future<String> signOut() async {
    String retVal = "error";

    try {
      await _auth.signOut();
      _uid = null;
      _email = null;
      retVal = "success";
    } catch (e) {
      debugPrint(e.toString());
    }
    return retVal;
  }

  Future<String> signupUser(String email, String password) async {
    String retVal = "error";
    try {
      UserCredential _authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (_authResult.user != null) {
        retVal = "success";
      }
    } catch (e) {
      retVal = e.toString();
    }
    return retVal;
  }

  Future<String> loginiUserWithEmail(String email, String password) async {
    String retVal = "error";
    try {
      UserCredential _authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (_authResult.user != null) {
        _uid = _authResult.user.uid;
        _email = _authResult.user.email;
        retVal = "success";
      }
    } catch (e) {
      retVal = e.toString();
    }
    return retVal;
  }

  Future<String> loginiUserWithGoogle() async {
    String retVal = "error";
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );

    try {
      GoogleSignInAccount _googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: _googleAuth.idToken, accessToken: _googleAuth.accessToken);
      UserCredential _authResult = await _auth.signInWithCredential(credential);
      if (_authResult.user != null) {
        _uid = _authResult.user.uid;
        _email = _authResult.user.email;
        retVal = "success";
      }
    } catch (e) {
      retVal = e.toString();
    }
    return retVal;
  }
}
