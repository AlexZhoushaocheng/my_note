import 'dart:developer';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DataAccessManger {
  static DataAccessManger _dataAccessManger;

  String _data = '';

  bool _isLoaded = false;

  DataAccessManger._();

  factory DataAccessManger() => _getInstance();

  static DataAccessManger _getInstance() {
    _dataAccessManger ??= new DataAccessManger._();
    return _dataAccessManger;
  }

  //[pulic]
  set data(String data) {
    _data = data;
    _saveData();
  }

  Future<String>  getData() async
  {
    if (!_isLoaded) {
      await _loadData();
      _isLoaded = true;
    }
    return _data;
  }
  //[pulic]

  //读取数据
  Future<bool> _loadData() async {
    Directory directory = await getApplicationDocumentsDirectory();
    File dataFile = File(directory.path + '/data');
    bool ret = await dataFile.exists();

    if (ret) {
      _data = await dataFile.readAsString();
    }
    return true;
  }

  //保存数据
  void _saveData() async {
    Directory directory = await getApplicationDocumentsDirectory();
    File dataFile = File(directory.path + '/data');
    await dataFile.writeAsString(_data);
  }
}
