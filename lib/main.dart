import 'package:flutter/material.dart';
import 'login.dart';

main(List<String> args) {

  runApp(MaterialApp(
    home: new Login(() {
      print("login sueccess!");
    }),
  ));
  
}
