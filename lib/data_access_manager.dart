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
  set data(data) {
    _data = data;
    _saveData();
  }

  String get data {
    if (!_isLoaded) {
      _loadData();
      _isLoaded = true;
    }

    return _data;
  }
  //[pulic]

  //读取数据
  void _loadData() async {
    Directory directory = await getApplicationDocumentsDirectory();
    File dataFile = File(directory.path + '/data');
    bool ret = await dataFile.exists();

    if (ret) {
      _data = await dataFile.readAsString();
    }
  }

  //保存数据
  void _saveData() async {
    Directory directory = await getApplicationDocumentsDirectory();
    File dataFile = File(directory.path + '/data');
    await dataFile.writeAsString(_data);
  }
}
