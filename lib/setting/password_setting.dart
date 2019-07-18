import 'package:flutter/material.dart';
import 'package:my_note/config_manger.dart';

class PasswordSetting extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PasswordSettingState();
  }
}

class PasswordSettingState extends State<PasswordSetting> {
  final String eyesClose = 'assets/image/eye_close.png';
  final String eyesOpen = 'assets/image/eye_open.png';

  bool oldFieldClosed = true; //旧密码编辑框的眼睛图标是否闭合
  bool newFieldClosed = true; //新密码编辑框的眼睛图标是否闭合

  bool hasPassword = false; //是否有旧的密码，第一次安装启动无旧密码

  //错误提示
  String oldFieldError;
  String newFieldError;

  //输入框内容
  final TextEditingController oldPasswordCtrl = TextEditingController();
  final TextEditingController newPasswordCtrl = TextEditingController();

  void onSave() {

    bool err = false;
    if (hasPassword && oldPasswordCtrl.text.isEmpty) {
        err = true;
        setState(() {
         oldFieldError = '旧密码不能为空'; 
        });
    }
    if(newPasswordCtrl.text.isEmpty){
        err = true;
        setState(() {
         newFieldError = '新密码不能为空'; 
        });
    }

    if(err){
      return;
    }
    else{
      if(oldPasswordCtrl.text != ConfigManager().password)
      {
        setState(() {
         oldFieldError = '旧密码错误'; 
        });
      }
      else
      {
        ConfigManager().password = newPasswordCtrl.text;
        Navigator.pop(context);
      }
    }
  }

  //改变旧密码的可见状态
  void changeOldEyes() {
    setState(() {
      oldFieldClosed = !oldFieldClosed;
    });
  }

  //改变新密码的可见状态
  void changeNewEyes() {
    setState(() {
      newFieldClosed = !newFieldClosed;
    });
  }

  @override
  void initState() {
    super.initState();
    hasPassword = ConfigManager().password.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '修改密码',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 50),
        child: Column(
          children: <Widget>[
            Offstage(
              offstage: !hasPassword,
              child: TextField(
                //旧密码
                controller: oldPasswordCtrl,
                keyboardType: TextInputType.number,
                obscureText: oldFieldClosed,
                maxLength: 4,
                decoration: InputDecoration(
                    errorText: oldFieldError,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Center(
                        child: Text('旧密码',style: TextStyle(fontSize: 14),),
                        widthFactor: 0,
                      ),
                    ),
                    hintText: '请填写旧密码',
                    hintStyle: TextStyle(fontSize: 14),
                    suffixIcon: GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Image.asset(
                          oldFieldClosed ? eyesClose : eyesOpen,
                          width: 5,
                        ),
                      ),
                      onTap: changeOldEyes,
                    )),
              ),
            ),
            TextField(
              //新密码
              controller: newPasswordCtrl,
              keyboardType: TextInputType.number,
              obscureText: newFieldClosed,
              maxLength: 4,
              decoration: InputDecoration(
                  errorText: newFieldError,
                  //contentPadding: EdgeInsets.symmetric(horizontal: 1),
                  prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Center(
                        child: Text('新密码',style: TextStyle(fontSize: 14),),
                        widthFactor: 0,
                      ),
                    ),
                  hintText: '请填写新密码',
                  hintStyle: TextStyle(fontSize: 14),
                  helperText: '密码长度4位，数字',
                  suffixIcon: GestureDetector(
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Image.asset(
                        newFieldClosed ? eyesClose : eyesOpen,
                        width: 5,
                        ),
                    ),
                    onTap: changeNewEyes,
                  )),
            ),
            FlatButton(
              child: Text('确认'),
              onPressed: () {
                onSave();
              },
            )
          ],
        ),
      ),
    );
  }
}
