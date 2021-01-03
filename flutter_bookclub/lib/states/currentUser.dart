import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bookclub/models/user.dart';
import 'package:flutter_bookclub/services/database.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CurrentUser extends ChangeNotifier {
  OurUser _currentUser;

  OurUser get getCurrentUser => _currentUser;

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> onStartUp() async {
    String retVal = "error";

    try {
      User _firebaseUser = await _auth.currentUser;
      _currentUser = await OurDatabase().getUserInfo(_firebaseUser.uid);
      if (_currentUser != null) {
        retVal = "success";
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return retVal;
  }

  Future<String> signOut() async {
    String retVal = "error";

    try {
      await _auth.signOut();
      _currentUser = OurUser();
      retVal = "success";
    } catch (e) {
      debugPrint(e.toString());
    }
    return retVal;
  }

  Future<String> signupUser(
      String email, String password, String fullName) async {
    String retVal = "error";
    OurUser _user = OurUser();
    try {
      UserCredential _authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _user.uid = _authResult.user.uid;
      _user.email = _authResult.user.email;
      _user.fullName = fullName;
      if (_authResult.user != null) {
        String retString = await OurDatabase().createDatabase(_user);
        if (retString == "success") {
          retVal = "success";
        }
      }
    } on PlatformException catch (e) {
      retVal = e.message;
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
        _currentUser = await OurDatabase().getUserInfo(_authResult.user.uid);
        debugPrint("currentUser :" + _currentUser.toString());
        if (_currentUser != null) {
          retVal = "success";
          debugPrint("currentUserUid :" + _currentUser.uid.toString());
          debugPrint("currentUserEmail :" + _currentUser.email.toString());
        }
      }
    } on PlatformException catch (e) {
      retVal = e.message;
    } catch (e) {
      retVal = e.toString();
    }
    return retVal;
  }

  Future<String> loginiUserWithGoogle() async {
    String retVal = "error";
    OurUser _user = OurUser();
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
      if (_authResult.additionalUserInfo.isNewUser) {
        _user.uid = _authResult.user.uid;
        _user.email = _authResult.user.email;
        _user.fullName = _authResult.user.displayName;
        OurDatabase().createDatabase(_user);
      }
      _currentUser = await OurDatabase().getUserInfo(_authResult.user.uid);
      if (_currentUser != null) {
        retVal = "success";
      }
    } on PlatformException catch (e) {
      retVal = e.message;
    } catch (e) {
      retVal = e.toString();
    }
    return retVal;
  }
}
