import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bookclub/models/book.dart';
import 'package:flutter_bookclub/models/group.dart';
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
        "groupId": user.groupId
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
      retVal.groupId = _documentSnapshot.data()["groupId"];
    } catch (e) {
      debugPrint(e.toString());
    }

    return retVal;
  }

  Future<String> createGroup(String groupName, String userUid) async {
    String retVal = "error";
    List<String> members = List();
    try {
      members.add(userUid);
      await _firestore.collection("groups").add({
        "name": groupName,
        "leader": userUid,
        "members": members,
        "groupCreated": Timestamp.now(),
      });
      retVal = "success";
    } catch (e) {
      debugPrint(e.toString());
    }
    return retVal;
  }

  Future<String> joinGroup(String groupId, String userUid) async {
    String retVal = "error";
    List<String> members = List();
    try {
      members.add(userUid);
      await _firestore.collection("groups").doc(groupId).update({
        "members": FieldValue.arrayUnion(members),
      });

      await _firestore.collection("users").doc(userUid).update({
        "groupId": groupId,
      });
      retVal = "success";
    } catch (e) {
      debugPrint(e.toString());
    }
    return retVal;
  }

  Future<OurGroup> getGroupInfo(String groupId) async {
    OurGroup retVal = OurGroup();
    try {
      DocumentSnapshot _documentSnapshot =
          await _firestore.collection("groups").doc(groupId).get();
      retVal.id = groupId;
      retVal.name = _documentSnapshot.data()["name"];
      retVal.leader = _documentSnapshot.data()["leader"];
      retVal.members = List<String>.from(_documentSnapshot.data()["members"]);
      retVal.groupCreated = _documentSnapshot.data()["groupCreated"];
      retVal.currentBookId = _documentSnapshot.data()["currentBookId"];
      retVal.currentBookDue = _documentSnapshot.data()["currentBookDue"];
    } catch (e) {
      debugPrint(e.toString());
    }

    return retVal;
  }

  Future<OurBook> getCurrentBook(String groupId, String bookId) async {
    OurBook retVal = OurBook();
    try {
      DocumentSnapshot _documentSnapshot = await _firestore
          .collection("groups")
          .doc(groupId)
          .collection("books")
          .doc(bookId)
          .get();
      retVal.id = bookId;
      retVal.name = _documentSnapshot.data()["name"];
      retVal.length = _documentSnapshot.data()["length"];
      retVal.author = _documentSnapshot.data()["author"];
      retVal.dateCompleted = _documentSnapshot.data()["dateCompleted"];
    } catch (e) {
      debugPrint(e.toString());
    }

    return retVal;
  }
}
