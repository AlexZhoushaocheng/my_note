import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';


class ConfigManger{

  factory ConfigManger()=> _getInstance();

  static ConfigManger _instance;

  ConfigManger._();
  

  static ConfigManger _getInstance()
  {
      if(null == _instance)
      {
        _instance = new ConfigManger._();
      }
      return _instance;
  }

  JsonCodec _jCodec = new JsonCodec();
  
  //密码
  String _strPassword = '';

  //文件路径
  String _strAppPath = '';

  //json 数据，包含所有配置
  Map<String,dynamic> _json = {};

  void loadConfig() async
  {
    Directory dir = await getApplicationDocumentsDirectory();
    _strAppPath = dir.path;

    File file = new File("$_strAppPath/config.json");

    String strJsonData = file.readAsStringSync();
    _json = _jCodec.decode(strJsonData);
    _strPassword = _json["password"];
  }

  void setPassword(String password)async
  {
      File file = new File("$_strAppPath/config.json");

      _json["password"] = password;

      await file.writeAsString(_jCodec.encode(_json));
  }

  String getPassword() => _strPassword;
}