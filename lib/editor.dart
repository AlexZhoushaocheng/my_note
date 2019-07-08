import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'account_model.dart';

class AccountEditor extends StatefulWidget {
  AccountEditor({Key key, @required this.account}) : super(key: key);
  final Account account;

  @override
  State<StatefulWidget> createState() {
    return AccountEditorState();
  }
}

class AccountEditorState extends State<AccountEditor> {

  AccountInfoTable accoutInfo; 

  void onSave()
  {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: Text('编辑'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: onSave, 
            )
          ],
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: accoutInfo,
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    accoutInfo = AccountInfoTable(widget.account);
  }
}

class AccountInfoTable extends StatelessWidget {
  AccountInfoTable(this._account);

  final Account _account;

  get account => _account;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text('名称'),
            TextField(
              controller: TextEditingController(text: _account.account),
              onSubmitted: (data) {
                _account.account = data;
              },
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Text('账号'),
            TextField(
                controller: TextEditingController(text: _account.username),
                onSubmitted: (data) {
                  _account.username = data;
                })
          ],
        ),
        Row(
          children: <Widget>[
            Text('密码'),
            TextField(
                controller: TextEditingController(text: _account.password),
                onSubmitted: (data) {
                  _account.password = data;
                })
          ],
        ),
        Row(
          children: <Widget>[
            Text('备注'),
            TextField(
                controller: TextEditingController(text: _account.remark),
                onSubmitted: (data) {
                  _account.remark = data;
                })
          ],
        )
      ],
    );
  }
}
