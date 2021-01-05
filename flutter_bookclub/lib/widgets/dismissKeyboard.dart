import 'package:flutter/material.dart';

class DismissKeyboard extends StatefulWidget {
  final Widget child;

  const DismissKeyboard({Key key, this.child}) : super(key: key);
  @override
  _DismissKeyboardState createState() => _DismissKeyboardState();
}

class _DismissKeyboardState extends State<DismissKeyboard> {
  _dismissKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: _dismissKeyboard, child: widget.child);
  }
}
