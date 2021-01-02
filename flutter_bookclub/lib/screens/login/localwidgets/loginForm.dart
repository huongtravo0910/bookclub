import 'package:flutter/material.dart';
import 'package:flutter_bookclub/screens/home/home.dart';
import 'package:flutter_bookclub/screens/signup/signup.dart';
import 'package:flutter_bookclub/states/currentUser.dart';
import 'package:provider/provider.dart';

class OurLoginForm extends StatefulWidget {
  @override
  _OurLoginFormState createState() => _OurLoginFormState();
}

class _OurLoginFormState extends State<OurLoginForm> {
  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  void _loginUser(String email, String password, BuildContext context) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    try {
      if (await CurrentUser().loginiUserWithEmail(email, password)) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text("Incorrect login info!"),
            duration: Duration(milliseconds: 2),
          ),
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Text(
            "Sign in",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              hintText: "   Enter your gmail address",
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              hintText: "   Enter your password",
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: RaisedButton(
            onPressed: () {
              _loginUser(
                  _emailController.text, _passwordController.text, context);
            },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 120, vertical: 5.0),
              child: Text(
                "Sign in",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            "Forgot your password?",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          height: 80.0,
        ),
        Text(
          "Or",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Theme.of(context).primaryColor),
        ),
        TextButton(
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sign in with Google",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              SizedBox(
                height: 30,
                width: 30,
                child: Container(
                    padding: EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                    child: Image.asset("assets/google-logo.png")),
              )
            ],
          ),
        ),
        Text("Don't have an account?"),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => OurSignup()),
            );
          },
          child: Text("Sign up here"),
        ),
      ],
    );
  }
}
