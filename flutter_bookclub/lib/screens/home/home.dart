import 'package:flutter/material.dart';
import 'package:flutter_bookclub/screens/root/rootScreen.dart';
import 'package:flutter_bookclub/states/currentUser.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("This is Home."),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () async {
            CurrentUser _user =
                Provider.of<CurrentUser>(context, listen: false);
            String _returnString = await _user.signOut();
            if (_returnString == "success") {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => OurRootScreen()),
                (route) => false,
              );
            }
          },
          child: Text("Sign out"),
        ),
      ),
    );
  }
}
