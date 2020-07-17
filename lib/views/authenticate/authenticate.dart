import 'package:dinci_samaan/views/authenticate/register.dart';
import 'package:dinci_samaan/views/authenticate/sign-in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      this.showSignIn = !this.showSignIn;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleView: toggleView);
    }
    return Register(toggleView:toggleView);
  }
}