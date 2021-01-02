import 'package:flutter/material.dart';

import 'localwidgets/loginForm.dart';

class OurLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(10.0),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 60, 30, 0),
                  child: Image.asset("assets/book-clubs-logo.png"),
                ),
                SizedBox(
                  height: 5,
                ),
                OurLoginForm(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
