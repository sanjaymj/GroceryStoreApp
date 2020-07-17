import 'package:dinci_samaan/services/firebase-auth.service.dart';
import 'package:dinci_samaan/utils/constants.dart';
import 'package:dinci_samaan/utils/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final FirebaseAuthService _auth = new FirebaseAuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return isLoading ? Loading(): Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0.0,
        title: Text('register In To App'),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () async {
              await widget.toggleView();
            },
            icon: Icon(Icons.person), 
            label: Text('Sign In'))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textFieldDecorator.copyWith(hintText: 'Email'),
                validator: (val) => val.isEmpty ? 'error' : null, 
                onChanged: (val) {
                  setState(() {
                    this.email = val;
                  });
                }
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textFieldDecorator.copyWith(hintText: 'Password'),
                validator: (val) => val.length < 6 ? 'short password' : null,
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
                    dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                    if (result == null) {
                      setState(() => {
                        isLoading = false,
                        error = 'Failed to register'
                      });
                    }
                  }
                }
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.green, fontSize: 14.0)
              )
            ]
          )
        )
      ),
    );
  }
}