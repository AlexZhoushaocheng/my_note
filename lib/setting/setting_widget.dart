import 'package:flutter/material.dart';
import 'package:my_note/setting/password_setting.dart';

class SettingWidget extends StatelessWidget {
  static String route = '/setting';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设置'),
      ),
      body: Column(
        children: <Widget>[ItemButton()],
      ),
    );
  }
}

class ItemButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Row(
        children: <Widget>[
          Text('密码设置'),
          Expanded(
            child: SizedBox(),
          ),
          Text(
            '修改',
            style: TextStyle(
              color: Colors.grey
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 15,
            color: Colors.grey,
          )
        ],
      ),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>new PasswordSetting()));
      },
    );
  }
}
