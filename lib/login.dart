import 'package:flutter/material.dart';
import 'config_manger.dart';

class Login extends StatefulWidget {

  static String route = '/login';
  
  Login();

  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {

  void checkPassword(String v) {
    if (v == ConfigManager().password) {
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
            keyboardType: TextInputType.number,
            showCursor: false,
            obscureText: true, 
            onChanged: checkPassword, 
            maxLength: 4,
            decoration: InputDecoration(
              semanticCounterText: null,
              counterText: null
            ),
            textAlign: TextAlign.center,
            ),
        )
      ),
    );
  }
}
