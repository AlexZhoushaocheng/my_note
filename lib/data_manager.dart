import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'account_model.dart';

class DataManger {
  factory DataManger() => _getInstance();

  static DataManger _instance;

  DataManger._();

  static DataManger _getInstance() {
    if (null == _instance) {
      _instance = new DataManger._();
    }
    return _instance;
  }

  JsonCodec _jCodec = new JsonCodec();

  //密码
  String _strPassword = '';

  //文件路径
  String _strAppPath = '';

  //json 数据，包含所有配置
  Map<String, dynamic> _json = {};

  Future<bool> loadConfig() async {
    Directory dir = await getApplicationDocumentsDirectory();
    _strAppPath = dir.path;

    File file = new File("$_strAppPath/config.json");

    String strJsonData = '';

    return await file.exists().then((success) {
      if (success) {
        strJsonData = file.readAsStringSync();
        _json = _jCodec.decode(strJsonData);
        _strPassword = _json["login_password"];

        print(_json);
        return true;
      } else {
        return false;
      }
    });
  }

  void setPassword(String password) async {
    _json["login_password"] = password;

    saveData();
  }

  //保存
  void saveData() async {
    File file = new File("$_strAppPath/config.json");
    await file.writeAsString(_jCodec.encode(_json), flush: true);
  }

  //插入
  void addAccountInfo(Account account) {
    List accList = _json['accountInfoList'];
    accList ??= [];
    accList.add(account.toMap());
    _json['accountInfoL ist'] = accList;
    saveData();
  }

  // 删除
  bool delAccountInfo(int id) {
    bool ret = false;
    List accList = _json['accountInfoList'];
    if (accList != null) {
      accList.forEach((e) {
        if (e is Map) {
          if (e['id'] == id) {
            ret = accList.remove(e);
            _json['accountInfoList'] = accList;
            saveData();
          }
        }
      });
    }
    return ret;
  }

  //修改
  bool modAccountInfo(Account account) {
    bool ret = false;
    List accList = _json['accountInfoList'];
    if (accList != null) {
      accList.forEach((e) {
        if (e is Map) {
          if (e['id'] == account.id) {
            ret = accList.remove(e);
            accList.add(account.toMap());
            _json['accountInfoList'] = accList;
            saveData();
          }
        }
      });
    }
    return ret;
  }

  //
  List<Account> getAccounts() {
    List<Account> accs = [];
    List accList = _json['accountInfoList'];
    if (accList != null) {
      accList.forEach((e) {
        if (e is Map) {
          accs.add(Account.formMap(e));
        }
      });
    }

    return accs;
  }

  String get password => _strPassword;
}
