import 'package:flutter/material.dart';
import 'package:flutter_bookclub/screens/createGroup/createGroup.dart';
import 'package:flutter_bookclub/screens/joinGroup/joinGroup.dart';

class OurNoGroup extends StatelessWidget {
  void _goToJoin(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => OurJoinGroup()));
  }

  void _goToCreate(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => OurCreateGroup()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Spacer(
            flex: 1,
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Image.asset("assets/book-clubs-logo.png"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Welcome to the BookClub",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 45.0,
              vertical: 20.0,
            ),
            child: Text(
              "Since you are not in the club, you can select to join a club or to create a club.",
              textAlign: TextAlign.center,
            ),
          ),
          Spacer(
            flex: 1,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    onPressed: () => _goToJoin(context),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(color: Colors.black, width: 1),
                    ),
                    child: Text("Join"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    onPressed: () => _goToCreate(context),
                    child: Text("Create"),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
