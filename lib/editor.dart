import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'account_model.dart';

class AccountEditor extends StatefulWidget {

  static String route = '/edit';

  AccountEditor({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AccountEditorState();
  }
}

class AccountEditorState extends State<AccountEditor> {

  Account account= Account();

  void onSave() {
    if(account.id.isNotEmpty)
    {
      Provider.of<AccountModel>(context).modify(account);
    }
    else
    {
      Provider.of<AccountModel>(context).add(account);
    }
    
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
            child: AccountInfoTable(account:ModalRoute.of(context).settings.arguments, accountChanged:(acc){
              account = acc;
              }
              ),
          ),
        ));
  }
}

class AccountInfoTable extends StatelessWidget {
  
  AccountInfoTable({this.account,this.accountChanged})
  {
    if(null == account)
    {
      account = Account(id: '');
    }
  }

  Account account;

  void Function(Account) accountChanged;

  void onItemChanged()
  {
    accountChanged(account);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text('名称'),
            Expanded(
                child: TextField(
                  controller: TextEditingController(text: account?.account),
                  decoration: InputDecoration(
                  //border: OutlineInputBorder(),
                  //labelText: 'p'
                  ),
              onChanged: (data) {
                account.account = data;
                onItemChanged();
              },
            )),
          ],
        ),
        Row(
          children: <Widget>[
            Text('账号'),
            Expanded(
              child: TextField(
                  controller: TextEditingController(text: account?.username),
                  onChanged: (data) {
                    account.username = data;
                    onItemChanged();
                  }),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Text('密码'),
            Expanded(
                child: TextField(
                    controller: TextEditingController(text: account?.password),
                    onChanged: (data) {
                      account.password = data;
                      onItemChanged();
                    }))
          ],
        ),
        Row(
          children: <Widget>[
            Text('备注'),
            Expanded(
                child: TextField(
                    controller: TextEditingController(text: account?.remark),
                    onChanged: (data) {
                      account.remark = data;
                      onItemChanged();
                    }))
          ],
        )
      ],
    );
  }
}
