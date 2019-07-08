import 'dart:collection';
import 'package:flutter/widgets.dart';
import 'data_manager.dart';

class Account{
  Account({this.id, this.account, this.username, this.password, this.remark});

  int id = 0;
  String account ='';
  String username = '';
  String password = '';
  String remark = '';

  Map toMap() => {'id':'$id','account':account,'username':account,'password':account,'remark':account= ''};

  Account.formMap(Map acc):
    id = acc['id'],
    account = acc['account'],
    username = acc['username'],
    password = acc['password'],
    remark = acc['remark'] ;
}

class AccountModel extends ChangeNotifier
{
  List<Account> _list = [];
  UnmodifiableListView<Account> get items => UnmodifiableListView(_list);

  void load({bool notify = true})
  {
    _list = DataManger().getAccounts();
    
    if(notify) notifyListeners();

    print("#### ${_list.length}");
  }

  void add(Account acc)
  {
    _list.add(acc);
    notifyListeners();
  }

  void modify(Account acc)
  {
    
  }
}

