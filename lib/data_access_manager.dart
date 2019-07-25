import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DataAccessManger {
  static DataAccessManger _dataAccessManger;

  String _data = '';

  bool _isInited = false;

  DataAccessManger._();

  factory DataAccessManger() => _getInstance();

  static DataAccessManger _getInstance() {
    _dataAccessManger ??= new DataAccessManger._();
    return _dataAccessManger;
  }

  //[pulic]
  Future<bool> init() async {
    bool ret = true;
    if (!_isInited) {
      ret = await _loadData();
      _isInited = true;
    }
    return ret;
  }

  set data(String data) {
    _data = data;
    _saveData();
  }

  String get data => _data;
  //[pulic]

  //读取数据
  Future<bool> _loadData() async {
    bool ret = true;
    try {
      Directory directory = await getApplicationDocumentsDirectory();
      File dataFile = File(directory.path + '/data');

      bool ret = await dataFile.exists();

      if (ret) {
        _data = await dataFile.readAsString();
      }
    } catch (ex) {
      ret = false;
    }
    return ret;
  }

  //保存数据
  void _saveData() async {
    Directory directory = await getApplicationDocumentsDirectory();

    File dataFile = File(directory.path + '/data');

    await dataFile.writeAsString(_data);
  }
}
