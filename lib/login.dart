import 'package:flutter/material.dart';
import 'package:my_note/config_manager.dart';

class Login extends StatefulWidget {
  Login(Function onSuccess) : this.loginSeccessCallBack = onSuccess;

  final Function loginSeccessCallBack;

  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  //TextField textField = new ;

  void checkPassword(String v) {
    if (v == ConfigManger().getPassword()) {
      widget.loginSeccessCallBack();

      Navigator.pushNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: TextField(
            obscureText: true, onChanged: checkPassword, maxLength: 4,decoration: InputDecoration(),textAlign: TextAlign.center,),widthFactor: 200,
      ),
    );
  }
}
