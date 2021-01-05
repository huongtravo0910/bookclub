import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bookclub/screens/login/login.dart';
import 'package:flutter_bookclub/screens/root/rootScreen.dart';
import 'package:flutter_bookclub/states/currentUser.dart';
import 'package:flutter_bookclub/utils/ourTheme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CurrentUser(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: OurTheme().builTheme(),
        home: CounterWidget(),
      ),
    );
  }
}

class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _counter = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            _counter.toString(),
          ),
          RaisedButton(
            onPressed: () {
              setState(() {
                _counter++;
              });
            },
            child: Text("INcrease"),
          ),
          Expanded(
            child: OurRootScreen(
              count: _counter,
            ),
          ),
        ],
      ),
    );
  }
}
