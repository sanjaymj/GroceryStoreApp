import 'package:dinci_samaan/services/firebase-auth.service.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {

  FirebaseAuthService _auth = FirebaseAuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text('My app'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () async {
              await _auth.signOut();
            }, 
            icon: Icon(Icons.person), 
            label: Text('label'))
        ],
      )
    );
  }
}