import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bookclub/models/book.dart';
import 'package:flutter_bookclub/models/group.dart';
import 'package:flutter_bookclub/services/database.dart';

class CurrentGroup extends ChangeNotifier {
  OurGroup _currentGroup = OurGroup();
  OurBook _currentBook = OurBook();
  bool _isDoneWithCurrentBook = false;

  OurGroup get getCurrentGroup => _currentGroup;
  OurBook get getCurrentBook => _currentBook;
  bool get getIsDoneWithCurrentBook => _isDoneWithCurrentBook;

  void updateStateFromDatabase(String groupId, String userUId) async {
    try {
      _currentGroup = await OurDatabase().getGroupInfo(groupId);
      _currentBook = await OurDatabase()
          .getCurrentBook(groupId, _currentGroup.currentBookId);
      notifyListeners();
      _isDoneWithCurrentBook = await OurDatabase()
          .isUserDoneWithBook(groupId, _currentGroup.currentBookId, userUId);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void finishedBook(String userUid, int rating, String reviews) async {
    try {
      String ret = await OurDatabase().finishedBook(_currentGroup.id,
          _currentGroup.currentBookId, userUid, rating, reviews);
      if (ret == "success") {
        _isDoneWithCurrentBook = true;
      } else {
        _isDoneWithCurrentBook = false;
      }
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
