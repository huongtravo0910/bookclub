import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bookclub/models/user.dart';

class OurDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createDatabase(OurUser user) async {
    String retVal = "error";
    try {
      await _firestore.collection("users").doc(user.uid).set({
        "uid": user.uid,
        "fullName": user.fullName,
        "email": user.email,
        "accountCreated": Timestamp.now(),
      });
      retVal = "success";
    } catch (e) {
      debugPrint(e.toString());
    }
    return retVal;
  }

  Future<OurUser> getUserInfo(String uid) async {
    OurUser retVal = OurUser();
    try {
      DocumentSnapshot _documentSnapshot =
          await _firestore.collection("users").doc(uid).get();
      retVal.email = _documentSnapshot.data()["email"];
      retVal.uid = _documentSnapshot.data()["uid"];
      retVal.fullName = _documentSnapshot.data()["fullName"];
      retVal.accountCreated = _documentSnapshot.data()["accountCreated"];
    } catch (e) {
      debugPrint(e.toString());
    }

    return retVal;
  }
}
