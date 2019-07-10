
import 'dart:convert';

import 'dart:io';

import 'package:path_provider/path_provider.dart';

class DataAccessManger {
  static DataAccessManger _dataAccessManger;

  final JsonDecoder _jsonDecoder = JsonDecoder();


  //私有化 默认构造
  DataAccessManger._();

  factory DataAccessManger() => _getInstance();

  static DataAccessManger _getInstance() {
    _dataAccessManger ??= new DataAccessManger();
    return _dataAccessManger;
  }

  void loadData() async
  {
      Directory directory = await getApplicationDocumentsDirectory();
      File dataFile = File(directory.path + '/data');
      bool ret = await dataFile.exists();

      if(ret)
      {

      }
  }
}
