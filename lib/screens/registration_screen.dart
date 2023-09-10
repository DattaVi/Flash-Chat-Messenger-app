import 'package:flutter/material.dart';
import 'loginregister.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = "registrationscreen";
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  var email;
  var password;
  var f = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: f,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  //Do something with the user input.
                  email = value;
                },
                decoration: Input,
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: Inputpass,
              ),
              SizedBox(
                height: 24.0,
              ),
              LoginRegister('Register', () async {
                // print(email);
                // print(password);
                setState(() {
                  f = true;
                });
                try {
                  final newUser = await _auth.createUserWithEmailAndPassword(
                      email: email, password: password);
                  if (newUser != null) {
                    Navigator.pushNamed(context, ChatScreen.id);
                  }
                  setState(() {
                    f = false;
                  });
                } catch (e) {
                  print(e);
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
