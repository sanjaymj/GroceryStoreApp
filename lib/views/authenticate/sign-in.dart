import 'package:dinci_samaan/services/firebase-auth.service.dart';
import 'package:dinci_samaan/utils/constants.dart';
import 'package:dinci_samaan/utils/loading.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final FirebaseAuthService _auth = new FirebaseAuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return isLoading ? Loading() : Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        title: Text('Dinci Samaan'),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () async {
              await widget.toggleView();
            },
            icon: Icon(Icons.person), 
            label: Text('Register'))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textFieldDecorator.copyWith(hintText: 'Email'),
                validator: (val) => !EmailValidator.validate(val) ? 'Email address is invalid' : null, 
                onChanged: (val) {
                  setState(() {
                    this.email = val;
                  });
                }
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textFieldDecorator.copyWith(hintText: 'Password'),
                validator: (val) => val.length < 6 ? 'Password is too short' : null,
                obscureText: true,
                onChanged: (val) {
                  setState(() {
                    this.password =val;
                  });
                }
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.pink,
                child: Text('Sign In', style: TextStyle(color: Colors.white)),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    setState(() => isLoading = true);
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if (result == null) {
                      setState(() => {
                        isLoading = false,
                        error = 'Failed to signIn'
                      });
                    }
                  }
                }),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red[200], fontSize: 20.0)
                )
            ]
          )
        )
      ),
      )
    );
  }
}