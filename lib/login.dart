import 'package:flutter/material.dart';
import 'data_manager.dart';

class Login extends StatefulWidget {
  Login();

  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {

  void checkPassword(String v) {
    if (v == DataManger().password) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100),
          child: TextField(
            obscureText: true, 
            onChanged: checkPassword, 
            maxLength: 4,
            decoration: InputDecoration(),
            textAlign: TextAlign.center,
            ),
        )
      ),
    );
  }
}
