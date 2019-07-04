import 'dart:collection';
import 'package:flutter/widgets.dart';

class Account{
  String username = '';
  String password = '';
  String remark = '';
}

class AccountModel extends ChangeNotifier
{
  final List<Account> _list = [];
  UnmodifiableListView<Account> get items => _list;

  void add(Account acc)
  {
    _list.add(acc);
    notifyListeners();
  }
}

