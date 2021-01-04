import 'package:flutter/material.dart';
import 'package:flutter_bookclub/screens/home/home.dart';
import 'package:flutter_bookclub/screens/login/login.dart';
import 'package:flutter_bookclub/screens/noGroupScreen/noGroup.dart';
import 'package:flutter_bookclub/screens/splashScreen/ourSplashScreen.dart';
import 'package:flutter_bookclub/states/currentGroup.dart';
import 'package:flutter_bookclub/states/currentUser.dart';
import 'package:provider/provider.dart';

enum AuthStatus {
  unknown,
  notLoggedIn,
  notInGroup,
  inGroup,
}

class OurRootScreen extends StatefulWidget {
  @override
  _OurRootScreenState createState() => _OurRootScreenState();
}

class _OurRootScreenState extends State<OurRootScreen> {
  AuthStatus _authStatus = AuthStatus.unknown;

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String _retString = await _currentUser.onStartUp();

    if (_retString == "success") {
      if (_currentUser.getCurrentUser.groupId != null) {
        debugPrint(
            "currentUserGroupId :" + _currentUser.getCurrentUser.groupId);
        setState(() {
          _authStatus = AuthStatus.inGroup;
        });
      } else {
        setState(() {
          _authStatus = AuthStatus.notInGroup;
        });
      }
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
      case AuthStatus.unknown:
        retVal = OurSplashScreen();
        break;
      case AuthStatus.notLoggedIn:
        retVal = OurLogin();
        break;
      case AuthStatus.notInGroup:
        retVal = OurNoGroup();
        break;
      case AuthStatus.inGroup:
        retVal = ChangeNotifierProvider(
          create: (context) => CurrentGroup(),
          child: HomeScreen(),
        );
        break;
      default:
    }
    return retVal;
  }
}
