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
  Account account = Account();
  final _formKey = GlobalKey<FormState>();

  void onSave() {
    if (_formKey.currentState.validate()) {

      _formKey.currentState.save();

      if (account.id.isNotEmpty) {
        Provider.of<AccountModel>(context).modify(account);
      } else {
        Provider.of<AccountModel>(context).add(account);
      }

      Navigator.pop(context);
    }
  }

  //AccountInfoTable accTable;

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context).settings.arguments != null) {
      account = ModalRoute.of(context).settings.arguments;
    } else {
      account.id = '';
    }

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
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    //账号名
                    initialValue: account?.account,
                    onSaved: (v) {
                      account.account = v;
                    },
                    validator: (v) {
                      String ret;
                      if (v.isEmpty) {
                        ret = '账号名不能为空';
                      }
                      return ret;
                    },
                    decoration: InputDecoration(
                        icon: SizedBox(
                      child: Text('账号名'),
                      width: 45,
                    )),
                  ),
                  TextFormField(
                    //用户名
                    initialValue: account?.username,
                    onSaved: (v) {
                      account.username = v;
                    },
                    validator: (v) {
                      String ret;
                      if (v.isEmpty) {
                        ret = '用户名不能为空';
                      }
                      return ret;
                    },
                    decoration: InputDecoration(
                        icon: SizedBox(
                      child: Text('用户名'),
                      width: 45,
                    )),
                  ),
                  TextFormField(
                    //密码
                    initialValue: account?.password,
                    onSaved: (v) {
                      account.password = v;
                    },
                    validator: (v) {
                      String ret;
                      if (v.isEmpty) {
                        ret = '密码不能为空';
                      }
                      return ret;
                    },
                    decoration: InputDecoration(
                        icon: SizedBox(
                      child: Text('密码'),
                      width: 45,
                    )),
                  ),
                  TextFormField(
                    //备注
                    initialValue: account?.remark,
                    onSaved: (v) {
                      account.remark = v;
                    },
                    //validator: (v) => '',
                    decoration: InputDecoration(
                        icon: SizedBox(
                      child: Text('备注'),
                      width: 45,
                    )),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
