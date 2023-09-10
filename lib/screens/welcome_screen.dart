import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'loginregister.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  var controller;
  var animation;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Flash Chat',
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 50.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                  onTap: () {
                    print("Tap Event");
                  },
                  pause: const Duration(milliseconds: 1500),
                  totalRepeatCount: 5,
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            LoginRegister('Login', () {
              Navigator.pushNamed(context, LoginScreen.id);
            }),
            LoginRegister('Register', () {
              Navigator.pushNamed(context, RegistrationScreen.id);
            }),
          ],
        ),
      ),
    );
  }
}

// Padding(
// padding: EdgeInsets.symmetric(vertical: 16.0),
// child: Material(
// elevation: 5.0,
// color: Colors.lightBlueAccent,
// borderRadius: BorderRadius.circular(30.0),
// child: MaterialButton(
// onPressed: () {
// Navigator.pushNamed(context, LoginScreen.id);
// },
// minWidth: 200.0,
// height: 42.0,
// child: Text(
// 'Log In',
// ),
// ),
// ),
// ),
