import 'package:flutter/material.dart';
import 'account_model.dart';
import 'login.dart';
import 'data_manager.dart';
import 'main_widget.dart';
import 'package:provider/provider.dart';

main(List<String> args) async {
  DataManger configManger = new DataManger();
  await configManger.loadConfig();

  Account account = Account(account: 'baidu',username: 'uname',password: '14725',remark: '');
  //configManger.addAccountInfo(account);

  runApp(new ChangeNotifierProvider(
    builder: (context) => AccountModel(),
    child: MaterialApp(
      home: configManger.password != null && configManger.password.isNotEmpty ? new Login() : new MainWidget(),

      routes: <String, WidgetBuilder>{
        "/home": (_) => new MainWidget(),
        "/login": (_) => new Login()
      },
    ),
  ));
}
