import 'package:flutter/material.dart';
import 'package:my_note/data_access_manager.dart';
import 'package:provider/provider.dart';
import 'account_model.dart';
import 'editor.dart';

class MainWidget extends StatefulWidget {
  static String route = '/home';

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
              icon: Icon(Icons.add), //新增
              onPressed: () {
                Navigator.pushNamed(context, AccountEditor.route);
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
          print('ID:${accounts.values.elementAt(index).account}');
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

class Item extends StatefulWidget {
  Item(this._account);

  final Account _account;

  @override
  State<StatefulWidget> createState() {
    return ItemState();
  }
}

class ItemState extends State<Item>
{
  
  bool editState = false;
  double btWidth = 0.0;

  onLongPress()
  {
    setState(() {
      editState = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //child: Text(?.account),
      child: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child:
                  Text(null == widget._account.account ? 'error' : widget._account.account),
            ),
            Container(
              width: !editState ? 0 : null,
              child: RaisedButton(
                child: Text('删除'),
                onPressed: () {
                  print('delete item');
                },
              ),
            )
          ],
        ),
        height: 25,
      ),
      onDoubleTap: () {
        Navigator.pushNamed(context, AccountEditor.route, arguments: widget._account);
      },
      onLongPress: onLongPress
    );
  }
}