import 'package:flutter/material.dart';
import 'package:flutter_bookclub/screens/home/home.dart';
import 'package:flutter_bookclub/screens/login/login.dart';
import 'package:flutter_bookclub/states/currentUser.dart';
import 'package:provider/provider.dart';

enum AuthStatus {
  notLoggedIn,
  loggedIn,
}

class OurRootScreen extends StatefulWidget {
  @override
  _OurRootScreenState createState() => _OurRootScreenState();
}

class _OurRootScreenState extends State<OurRootScreen> {
  AuthStatus _authStatus = AuthStatus.notLoggedIn;

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    CurrentUser _user = Provider.of<CurrentUser>(context, listen: false);
    String _retString = await _user.onStartUp();
    if (_retString == "success") {
      setState(() {
        _authStatus = AuthStatus.loggedIn;
      });
    } else {
      setState(() {
        _authStatus = AuthStatus.notLoggedIn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget retVal;
    switch (_authStatus) {
      case AuthStatus.notLoggedIn:
        retVal = OurLogin();
        break;
      case AuthStatus.loggedIn:
        retVal = HomeScreen();
        break;
      default:
    }
    return retVal;
  }
}
