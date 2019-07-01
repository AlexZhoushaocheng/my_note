import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  Login(Function f) : this.loginSeccessCallBack = f;

  final Function loginSeccessCallBack;

  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  //TextField textField = new ;

  void checkPassword(String v) {
    if (v == '1234') {
      widget.loginSeccessCallBack();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text(''),
      ),
      body: Center(
        child: TextField(
            obscureText: true, onChanged: checkPassword, maxLength: 4),
      ),
    );
  }
}
