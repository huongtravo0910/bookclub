import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bookclub/screens/addBook/addBook.dart';
import 'package:flutter_bookclub/screens/reviewBook/reviewBook.dart';
import 'package:flutter_bookclub/screens/root/rootScreen.dart';
import 'package:flutter_bookclub/states/currentGroup.dart';
import 'package:flutter_bookclub/states/currentUser.dart';
import 'package:flutter_bookclub/utils/timeLeft.dart';
import 'package:flutter_bookclub/widgets/ourContainer.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> _timeUtil = List(2);
  Timer _timer;
  void _startTimer(CurrentGroup currentGroup) {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _timeUtil = OurTimeLeft()
            .timeLeft(currentGroup.getCurrentGroup.currentBookDue.toDate());
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);

    CurrentGroup _currentGroup =
        Provider.of<CurrentGroup>(context, listen: false);
    _currentGroup.updateStateFromDatabase(
        _currentUser.getCurrentUser.groupId, _currentUser.getCurrentUser.uid);
    _startTimer(_currentGroup);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _signOut(BuildContext context) async {
    CurrentUser _user = Provider.of<CurrentUser>(context, listen: false);
    String _returnString = await _user.signOut();
    if (_returnString == "success") {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => OurRootScreen()),
        (route) => false,
      );
    }
  }

  void _goToReview(BuildContext context) {
    CurrentGroup _currentGroup =
        Provider.of<CurrentGroup>(context, listen: false);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => OurReview(
              currentGroup: _currentGroup,
            )));
  }

  void _goToAddBook(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => OurAddBook(
              onGroupCreation: false,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        body: ListView(
          children: [
            SizedBox(height: 40),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: OurContainer(
                child: Consumer<CurrentGroup>(
                    builder: (BuildContext context, value, Widget child) {
                  return Column(
                    children: [
                      Text(
                        value.getCurrentBook.name ?? "loading...",
                        style: TextStyle(
                            fontSize: 24,
                            color: Theme.of(context).primaryColor),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        children: [
                          Text(
                            "Due in: ",
                            style: TextStyle(
                              fontSize: 24,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              _timeUtil[0] ?? "loading...",
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      RaisedButton(
                        onPressed: () {
                          CurrentGroup _currentGroup =
                              Provider.of<CurrentGroup>(context, listen: false);
                          debugPrint(_currentGroup.getIsDoneWithCurrentBook
                              .toString());
                          value.getIsDoneWithCurrentBook
                              ? null
                              : _goToReview(context);
                        },
                        child: Text(
                          "Finished book",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  );
                }),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: OurContainer(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Next book \nRevealed in : ",
                      style: TextStyle(
                          fontSize: 24, color: Theme.of(context).primaryColor),
                    ),
                    Text(_timeUtil[1] ?? "loading...",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
              child: RaisedButton(
                onPressed: () {
                  _goToAddBook(context);
                },
                child: Text(
                  "BookClub History",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: RaisedButton(
                onPressed: () => _signOut(context),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(color: Colors.black, width: 1),
                ),
                child: Text("Sign Out"),
              ),
            )
          ],
        ));
  }
}
