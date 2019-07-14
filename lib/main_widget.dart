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

class ItemState extends State<Item> {
  void onDelete(DismissDirection direction) {
    print('del ${widget._account.account}');
    Provider.of<AccountModel>(context).delete(widget._account.id);
  }

  Future<bool> confirm(DismissDirection direction) async {
    return direction == DismissDirection.endToStart;
  }

  void onEdit()
  {
    Navigator.pushNamed(context, AccountEditor.route,arguments: widget._account);
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      //child: Text(?.account),
      key: Key(widget._account.id),
      child: GestureDetector(
        onDoubleTap: onEdit,
        child: Container(
          child: Text(null == widget._account.account ? 'error' : widget._account.account),
          height: 25,
        ),
      ),
      onDismissed: onDelete,
      confirmDismiss: confirm,
      direction: DismissDirection.endToStart,
      dismissThresholds: {DismissDirection.endToStart: 0.25},
      background: Container(
        color: Colors.red[100],
        child: Text('删除'),
        alignment: Alignment.centerRight,
      ),
    );
  }
}
