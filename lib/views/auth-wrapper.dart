import 'package:dinci_samaan/models/user.dart';
import 'package:dinci_samaan/views/authenticate/authenticate.dart';
import 'package:dinci_samaan/views/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return Authenticate();
    }
    print('!!!!!!!!!');
    print(user.uid);
    return Home(uid: user.uid);
    
  }
}