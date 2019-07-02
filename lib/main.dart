import 'package:flutter/material.dart';
import 'login.dart';
import 'config_manager.dart';
import 'main_widget.dart';

main(List<String> args)async {

ConfigManger configManger = new ConfigManger();
await configManger.loadConfig().then((value){
  if(value)
  {
    print('success');
  }
  else 
  {
    print('load config failed');
    //configManger.setPassword('3456');
  }
  });

runApp(MaterialApp(
    home: configManger.getPassword().isNotEmpty ? new Login((){}) : new MainWidget(),
    routes: <String,WidgetBuilder>{
      "/home" : (_) => new MainWidget(),
      "/login" : (_) => new Login((){})
    },
  ));

//如果配置中密码不为空，则转到登陆页面
// if(configManger.getPassword().isNotEmpty)
// {

// }

  // runApp(MaterialApp(
  //   home: new Login(() {
  //     print("login sueccess!");
  //   }),
  // ));
  
}
