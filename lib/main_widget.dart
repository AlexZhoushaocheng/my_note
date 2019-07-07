import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data_manager.dart';
import 'account_model.dart';


class MainWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MainWidgetState();
  }

  
}

class MainWidgetState extends State<MainWidget>{
  @override
  Widget build(BuildContext context) {

    var accounts = Provider.of<AccountModel>(context).items;

    return new Scaffold(
      appBar: AppBar(
        leading: new IconButton(icon: Icon(Icons.home),onPressed: (){},),
        title: Text("MyNote"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add),onPressed: (){
            Provider.of<AccountModel>(context).add(Account(account: "account"));
          }),
          IconButton(icon: Icon(Icons.search),onPressed: (){},),
          IconButton(icon: Icon(Icons.menu),onPressed: (){},),
        ],
        ),
        body: ListView(
          children: List<Widget>.generate(accounts.length, (index){return GestureDetector(child: Text('${accounts[index].account}'));}),
        ),
    );
  }

  @override
  void initState() {
    super.initState();
    Provider.of<AccountModel>(context,listen: false).load(notify: false);
  }
}