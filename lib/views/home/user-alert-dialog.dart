import 'package:flutter/material.dart';

class UserAlertDialog extends StatelessWidget {
  final String alertText;
  Function() callback;

  UserAlertDialog({this.alertText, this.callback});

  @override
  Widget build(BuildContext context) {
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed:  () {
        this.callback();
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    return AlertDialog(
      title: Text("AlertDialog"),
      content: Text(this.alertText),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    
  }
}