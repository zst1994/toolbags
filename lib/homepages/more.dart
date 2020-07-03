import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toolbag/config/common.dart';
import 'package:toolbag/provide/more.dart';

class MorePages extends StatelessWidget {
  Map moreDataList;

  @override
  Widget build(BuildContext context) {
    _show(context);

    return Provide<MoreProvide>(builder: (context, child, val) {
      moreDataList = Provide.value<MoreProvide>(context).dataList;
      return ListView(
        children: <Widget>[
          Container(
            color: Color(0xff09abf7),
            padding: EdgeInsets.only(top: 150.w, bottom: 120.w),
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {
                if (!moreDataList["login"]) {
                  Navigator.pushNamed(context, '/login');
                } else {
                  Navigator.pushNamed(context, '/personal');
                }
              },
              child: Column(
                children: <Widget>[
                  ClipOval(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: moreDataList["headBool"]
                          ? Image.file(
                              File(moreDataList["path"]),
                              width: 200.w,
                              height: 200.w,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              moreDataList["path"],
                              width: 200.w,
                              height: 200.w,
                              fit: BoxFit.cover,
                            )),
                  SizedBox(
                    height: 20.w,
                  ),
                  Text(
                    moreDataList["user"],
                    style: myTextStyle(40, 0xffffffff, false),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 40.w,
          ),
          InkWell(
            onTap: () {
              if (!moreDataList["login"]) {
                Navigator.pushNamed(context, '/login');
              } else {
                Navigator.pushNamed(context, '/personal');
              }
            },
            child: Container(
              height: 100.h,
              color: Colors.white,
              padding: EdgeInsets.only(
                  left: 40.w, right: 40.w, top: 30.w, bottom: 30.w),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    'images/card.png',
                    width: 60.w,
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(left: 20.w),
                        alignment: Alignment.centerLeft,
                        child: Text("个人资料"),
                      )),
                  Icon(
                    Icons.keyboard_arrow_right,
                    size: 24,
                  )
                ],
              ),
            ),
          ),
          Divider(
            height: 1.w,
            color: Color(0xff999999),
          ),
          InkWell(
            onTap: () {
              showMyMaterialDialog(context);
            },
            child: Container(
              height: 100.h,
              color: Colors.white,
              padding: EdgeInsets.only(
                  left: 40.w, right: 40.w, top: 30.w, bottom: 30.w),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    'images/exit.png',
                    width: 60.w,
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(left: 20.w),
                        alignment: Alignment.centerLeft,
                        child: Text("退出登录"),
                      )),
                  Icon(
                    Icons.keyboard_arrow_right,
                    size: 24,
                  )
                ],
              ),
            ),
          )
        ],
      );
    });
  }

  void showMyMaterialDialog(BuildContext context) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Center(
              child: Text(
                '提示',
                style: myTextStyle(36, 0xff2b2b2b, false),
              ),
            ),
            content: Column(
              children: <Widget>[
                SizedBox(
                  height: 18.h,
                ),
                Text(
                  '确认退出登录吗?',
                  style: myTextStyle(32, 0xff666666, false),
                ),
                SizedBox(
                  height: 8.h,
                ),
              ],
            ),
            actions: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 6.w, bottom: 6.w),
                child: FlatButton(
                  onPressed: () => Navigator.of(context).pop("点击了取消"),
                  child: Text(
                    "取消",
                    style: TextStyle(
                        fontSize: 34.sp,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 6.w, bottom: 6.w),
                child: FlatButton(
                  onPressed: () {
                    _clear();
                    Provide.value<MoreProvide>(context).setVal({
                      "user": "请先登录",
                      "login": false,
                      "path": "images/head_boy.png",
                      "headBool": false
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "确认退出",
                    style: myTextStyle(34, 0xff3594ff, true),
                  ),
                ),
              ),
            ],
          );
        });
  }

  void _show(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('login') != null) {
      Provide.value<MoreProvide>(context).setVal({
        "user": prefs.getString('user'),
        "login": prefs.getBool('login'),
        "path": prefs.getString("path") ?? "images/head_boy.png",
        "headBool": prefs.getBool("headBool") ?? false
      });
    }
  }

  void _clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.clear(); //全部清空
    prefs.remove('user'); //删除key键
    prefs.remove('login'); //删除key键
    prefs.remove('path'); //删除key键
    prefs.remove('headBool'); //删除key键
  }
}
