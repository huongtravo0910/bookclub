import 'package:flutter/material.dart';

class OurTheme {
  Color _white = Color.fromARGB(255, 255, 255, 255);
  Color _greyLight = Color.fromARGB(255, 242, 242, 242);
  Color _greyDark = Color.fromARGB(255, 130, 130, 130);
  Color _blueLight = Color.fromARGB(242, 86, 204, 242);
  Color _orange = Color.fromARGB(255, 242, 153, 74);

  ThemeData builTheme() {
    return ThemeData(
      canvasColor: _greyLight,
      primaryColor: _greyDark,
      secondaryHeaderColor: _greyLight,
      accentColor: _orange,
      hintColor: _greyDark,
      inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(color: _greyLight),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(color: _greyDark),
          ),
          hintStyle: TextStyle(fontSize: 14)),
      buttonTheme: ButtonThemeData(
        buttonColor: _greyDark,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        minWidth: 150,
        height: 40.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
      ),
    );
  }
}
