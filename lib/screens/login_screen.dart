import 'package:flutter/material.dart';
import 'loginregister.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static String id = "loginscreen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              LoginRegister('Login', () async {
                print(email);
                print(password);
                setState(() {
                  f = true;
                });
                try {
                  final userCredential = await _auth.signInWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                  print("User is signed in: ${userCredential.user}");
                  Navigator.pushNamed(context, ChatScreen.id);
                  setState(() {
                    f = false;
                  });
                } catch (error) {
                  // Handle errors, which can include invalid credentials or other issues
                  final errorCode = (error as FirebaseAuthException).code;
                  final errorMessage = (error as FirebaseAuthException).message;
                  print("Error signing in: $errorCode $errorMessage");
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
