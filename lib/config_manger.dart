import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ConfigManager {
  //pulic:
  factory ConfigManager() => _instance;

  set password(password) {
    _config["password"] = password;
    _saveConfig();
  }

  String get password => _config["password"];

  //private:
  ConfigManager._();

  static ConfigManager _configManager;

  static get _instance {
    _configManager ??= new ConfigManager._();

    if (false == _configManager._isLoaded) {
      _configManager._loadConfig();
    }
    return _configManager;
  }

  bool _isLoaded = false;

  Map<String, dynamic> _config = {};

  void _loadConfig() async {
    _isLoaded = true;

    Directory dir = await getApplicationDocumentsDirectory();
    File configFile = File("${dir.path}/config");

    String data = '';
    await configFile.exists().then((isExist) async {
      if (isExist) {
        data = await configFile.readAsString();
      }
    });
    _parse(data);
  }

  void _saveConfig() async {
    Directory dir = await getApplicationDocumentsDirectory();
    File configFile = File("${dir.path}/config");

    await configFile.writeAsString(json.encode(_config));
  }

  void _parse(String data) {
    print("parse");
    try {
      _config = json.decode(data);
      if (!_config.containsKey('password')) {
        _config['password'] = '';
      }
    } catch (ex) {
      _config['password'] = '';
    }
  }
}
