import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toolbag/config/common.dart';

class MorePages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: Color(0xff09abf7),
          padding: EdgeInsets.only(top: 180.w, bottom: 150.w),
          alignment: Alignment.center,
          child: InkWell(
            onTap: () {
              print('object');
            },
            child: Column(
              children: <Widget>[
                Image.asset(
                  'images/head_boy.png',
                  width: 200.w,
                ),
                SizedBox(
                  height: 20.w,
                ),
                Text(
                  '请先登录',
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
            print('object');
          },
          child: Container(
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
            print('object');
          },
          child: Container(
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
  }
}
