import 'package:flutter/material.dart';
import 'package:my_note/setting/setting_widget.dart';
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
          // IconButton(
          //   icon: Icon(Icons.search),
          //   onPressed: () {
          //     print(DataAccessManger().data);
          //   },
          // ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, SettingWidget.route);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: ListView(
        children: List<Widget>.generate(accounts.length, (index) {
          //print('ID:${accounts.values.elementAt(index).account}');
          return Item(accounts.values.elementAt(index),index);
        }),
      ),
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
  Item(this._account,this.index);

  final Account _account;
  final int index;

  @override
  State<StatefulWidget> createState() {
    return ItemState();
  }
}

class ItemState extends State<Item> {
  void onDelete(DismissDirection direction) {
    //print('del ${widget._account.account}');
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
        onTap: (){
          showDialog(
          context: context,
          builder: (BuildContext context)=>SimpleDialog(
            title: Text(widget._account.account),
            contentPadding: EdgeInsets.fromLTRB(12, 0, 12, 12),
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 50,
                    child: Text('用户名:', textWidthBasis: TextWidthBasis.parent,
                      textAlign: TextAlign.right,),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(widget._account.username)
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 50,
                    child: Text('密码:', textWidthBasis: TextWidthBasis.parent,
                      textAlign: TextAlign.right,),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(widget._account.password)
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 50,
                    child: Text('备注:', textWidthBasis: TextWidthBasis.parent,
                      textAlign: TextAlign.right,),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(widget._account.remark)
                  )
                ],
              ),
            ],
          )
          );
        },
        onDoubleTap: onEdit,
        child:Container(
          child: Row(
            children: <Widget>[
              SizedBox(width: 40,),
              SizedBox(width: 80,
              child: Text(widget._account.account),
              ),
              SizedBox(width: 20,),
              Text(widget._account.username)
            ],
          ),
          height: 45,
          color: widget.index % 2 ==0? Colors.grey[300] : Colors.white,
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
