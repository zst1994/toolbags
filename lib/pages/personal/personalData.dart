import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import 'package:toolbag/config/common.dart';
import 'package:toolbag/provide/more.dart';

class PersonalPage extends StatelessWidget {
  Map moreDataList;

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
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(
                  left: 40.w, right: 40.w, top: 20.w, bottom: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '账号',
                    style: myTextStyle(30, 0xff333333, false),
                  ),
                  Text(moreDataList["user"],
                      style: myTextStyle(30, 0xff333333, false))
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
