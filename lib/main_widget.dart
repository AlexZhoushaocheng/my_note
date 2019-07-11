import 'package:flutter/material.dart';
import 'package:my_note/data_access_manager.dart';
import 'package:provider/provider.dart';
import 'account_model.dart';

class MainWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainWidgetState();
  }
}

class MainWidgetState extends State<MainWidget> {
  @override
  Widget build(BuildContext context) {
    var accounts = Provider.of<AccountModel>(context).items;

    return new Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: Icon(Icons.home),
          onPressed: () {},
        ),
        title: Text("MyNote"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Provider.of<AccountModel>(context)
                    .add(Account(account: "account"));
              }),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              print(DataAccessManger().data);
            },
          ),
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: List<Widget>.generate(accounts.length, (index) {
          return Item(accounts.values.elementAt(index));
        }),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Provider.of<AccountModel>(context, listen: false).load();
  }
}

class Item extends Container{

  Item(this._account);

  final Account _account;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Text(_account?.account),
      onDoubleTap: (){
        Navigator.pushNamed(context, '/edit',arguments: _account);
      },
    );
  }
}