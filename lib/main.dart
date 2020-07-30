import 'package:dinci_samaan/models/user.dart';
import 'package:dinci_samaan/services/firebase-auth.service.dart';
import 'package:dinci_samaan/views/auth-wrapper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
void main() {
  
    runApp(new MyApp());
  
}
final FirebaseAuth auth = FirebaseAuth.instance;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: FirebaseAuthService().user,
      child: MaterialApp(
        home: AuthWrapper(),
      )

    );
  }
}