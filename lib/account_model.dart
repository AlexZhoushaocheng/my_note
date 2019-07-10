import 'dart:collection';
import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'data_access_manager.dart';
import 'dart:convert';

class Account{
  Account({this.id, this.account, this.username, this.password, this.remark});

  int id = 0;
  String account ='';
  String username = '';
  String password = '';
  String remark = '';

  Map toMap() => {'id':'$id','account':account,'username':account,'password':account,'remark':account= remark};

  dynamic toJson() => {'id':'$id','account':account,'username':account,'password':account,'remark':remark};

  Account.formMap(Map acc):
    id = acc['id'],
    account = acc['account'],
    username = acc['username'],
    password = acc['password'],
    remark = acc['remark'] ;
}

class AccountModel extends ChangeNotifier
{
  Map<int,Account> _accountItems = {};

  UnmodifiableMapView<int,Account> get items => UnmodifiableMapView(_accountItems);

  //加载数据
  void load()
  {
    _parse(DataAccessManger().data);
  }

  //新增
  void add(Account acc)
  {
    acc.id = _getID();
    _accountItems[acc.id] = acc;
    notifyListeners();
    _save();
  }

  //修改
  void modify(Account acc)
  {
    if(_accountItems.containsKey(acc.id))
    {
      _accountItems[acc.id] = acc;
      notifyListeners();
      _save();
    }
  }

  //删除
  void delete(int id)
  {
    _accountItems.remove(id);
    notifyListeners();
    _save();
  }

  //解析原生数据
  void _parse(String data)
  {
    if(data.isNotEmpty)
    {
      try{
        Map<int,dynamic> accountItems = json.decode(data);
        for(var item in accountItems.values)
        {
          _accountItems[item['id']] = item;
        }
      }
      catch(ex)
      {
        throw "parse failed";
      }
    }
  }

  //获取一个可用ID
  int _getID()
  {
    int id = 0;
    while(_accountItems.containsKey(id++)){}

    return id;
  }

  void _save()
  {
    json.encode(_accountItems);
  }
}

