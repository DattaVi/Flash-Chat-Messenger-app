import 'package:flutter/material.dart';

class LoginRegister extends StatelessWidget {
  LoginRegister(this.str, this.fun);

  var str;
  var fun;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: () {
            fun();
          },
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            str,
          ),
        ),
      ),
    );
  }
}
