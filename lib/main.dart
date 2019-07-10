import 'package:flutter/material.dart';
import 'account_model.dart';
import 'login.dart';
import 'main_widget.dart';
import 'package:provider/provider.dart';
import 'editor.dart';
import 'config_manger.dart';

main(List<String> args) async {

  Account account = Account(account: 'baidu',username: 'uname',password: '14725',remark: '');
  //configManger.addAccountInfo(account);

  runApp(new ChangeNotifierProvider(
    builder: (context) => AccountModel(),
    child: MaterialApp(
      home: ConfigManager().password != null && ConfigManager().password.isNotEmpty ? new Login() : new MainWidget(),

      routes: <String, WidgetBuilder>{
        "/home": (context) => new MainWidget(),
        "/login": (context) => new Login(),
        "/edit":(context,{Account account}) => new AccountEditor(account: account,),
      },
    ),
  ));
}
