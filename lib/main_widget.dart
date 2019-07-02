import 'package:flutter/material.dart';

class MainWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MainWidgetState();
  }
}

class MainWidgetState extends State<MainWidget>{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        leading: new IconButton(icon: Icon(Icons.arrow_back),onPressed: (){},),
        title: Text("MyNote"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add),onPressed: (){},),
          IconButton(icon: Icon(Icons.search),onPressed: (){},),
          IconButton(icon: Icon(Icons.menu),onPressed: (){},),
        ],
        ),
        body: ListView(
          children: <Widget>[
            
          ],
        ),
    );
  }
}