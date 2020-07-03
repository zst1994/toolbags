import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provide/provide.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:toolbag/config/common.dart';
import 'package:toolbag/provide/more.dart';

class PersonalPage extends StatelessWidget {
  Map moreDataList;

  final ImagePicker _picker = ImagePicker();

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
          backgroundColor: Theme.of(context).accentColor,
          title: Text(
            "个人资料",
            style: myTextStyle(38, 0xffffffff, false),
          )),
      body: Provide<MoreProvide>(builder: (context, child, val) {
        moreDataList = Provide.value<MoreProvide>(context).dataList;

        return ListView(
          padding: EdgeInsets.only(top: 30.w),
          children: <Widget>[
            InkWell(
              onTap: () {
                // Navigator.pushNamed(context, '/photo');
                _onImageButtonPressed(ImageSource.gallery, context: context);
              },
              child: Container(
                padding: EdgeInsets.only(
                    left: 40.w, right: 20.w, top: 20.w, bottom: 20.w),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom:
                            BorderSide(width: 1.w, color: Color(0xffcccccc)))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '头像',
                      style: myTextStyle(34, 0xff666666, false),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 90.w,
                          height: 90.w,
                          child: ClipOval(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: moreDataList["headBool"]
                                  ? Image.file(
                                      File(moreDataList["path"]),
                                      width: 90.w,
                                      height: 90.w,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      moreDataList["path"],
                                      width: 90.w,
                                      height: 90.w,
                                      fit: BoxFit.cover,
                                    )),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Icon(
                          Icons.keyboard_arrow_right,
                          size: 24,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 130.w,
              color: Colors.white,
              padding: EdgeInsets.only(
                  left: 40.w, right: 40.w, top: 20.w, bottom: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '账号',
                    style: myTextStyle(34, 0xff666666, false),
                  ),
                  Text(moreDataList["user"],
                      style: myTextStyle(34, 0xff333333, true))
                ],
              ),
            )
          ],
        );
      }),
    );
  }

  _onImageButtonPressed(ImageSource source, {BuildContext context}) async {
    try {
      final pickedFile = await _picker.getImage(source: source);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('path', pickedFile.path);
      prefs.setBool('headBool', true);
      Provide.value<MoreProvide>(context).setVal({
        "user": moreDataList["user"],
        "login": moreDataList["login"],
        "path": pickedFile.path,
        "headBool": true
      });
    } catch (e) {
      print(e);
    }
  }
}
