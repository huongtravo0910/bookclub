import 'package:flutter/material.dart';

import 'localwidgets/signupForm.dart';

class OurSignup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.fromLTRB(20, 100, 20, 20),
              children: [
                OurSignupForm(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
