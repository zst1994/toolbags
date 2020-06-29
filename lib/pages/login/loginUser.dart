import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import 'package:toolbag/config/common.dart';
import 'package:toolbag/provide/more.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfff3f3f3),
      appBar: AppBar(
          elevation: 0.0,
          leading: IconButton(
              icon: Image.asset(
                'images/fanhui_01@2x.png',
                width: 18.w,
              ),
              onPressed: () => Navigator.pop(context)),
          centerTitle: true,
          backgroundColor: Color(0xff09abf7),
          title: Text(
            "登录",
            style: myTextStyle(38, 0xffffffff, false),
          )),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 37.h),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5.w)),
            child: TextField(
              controller: _userController,
              decoration: InputDecoration(
                  hintText: "请输入账号",
                  border: InputBorder.none,
                  counterText: "",
                  contentPadding:
                      EdgeInsets.only(left: 46.w, top: 32.h, bottom: 32.h),
                  hintStyle: myTextStyle(32, 0xff999999, false)),
              maxLength: 12,
              style: myTextStyle(32, 0xff333333, false),
            ),
          ),
          Divider(
            height: 1.w,
            color: Color(0xffcccccc),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 37.h),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5.w)),
            child: TextField(
              controller: _passController,
              obscureText: true,
              decoration: InputDecoration(
                  hintText: "请输入密码",
                  border: InputBorder.none,
                  counterText: "",
                  contentPadding:
                      EdgeInsets.only(left: 46.w, top: 32.h, bottom: 32.h),
                  hintStyle: myTextStyle(32, 0xff999999, false)),
              maxLength: 12,
              style: myTextStyle(32, 0xff333333, false),
            ),
          ),
          InkWell(
            onTap: () {
              if (_userController.text.isEmpty) {
                shortToast("账号不能为空");
              } else {
                if (_passController.text.isEmpty) {
                  shortToast("密码不能为空");
                } else {
                  if (_userController.text != "admin") {
                    shortToast("账号错误");
                  } else {
                    if (_passController.text != "123123") {
                      shortToast("账号错误");
                    } else {
                      print(_userController.text);
                      print(_passController.text);
                      Provide.value<MoreProvide>(context).setVal(
                          {"user": _userController.text, "login": true});
                      Navigator.pop(context);
                    }
                  }
                }
              }
            },
            child: Container(
              width: 630.w,
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 24.w, bottom: 24.w),
              decoration: BoxDecoration(
                  color: Color(0xff09abf7),
                  borderRadius: BorderRadius.circular(60.w)),
              child: Text(
                '登录',
                style: myTextStyle(34, 0xffffffff, true),
              ),
            ),
          )
        ],
      ),
    );
  }
}
