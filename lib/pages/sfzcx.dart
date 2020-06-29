import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import 'package:toolbag/config/common.dart';
import 'package:toolbag/provide/sfzcx.dart';

class SFZCX extends StatelessWidget {
  Map arguments;
  SFZCX({this.arguments});
  final TextEditingController _searchController = TextEditingController();
  Map sfzData;
  String sex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              arguments["title"],
              style: myTextStyle(38, 0xffffffff, false),
            )),
        body: ListView(
          children: <Widget>[
            searchTitle(context, _searchController, "请输入身份证号码查询", () {
              getHttp(context, arguments["url"], {
                "showapi_appid": "164005",
                "showapi_sign": "752362a805704af9bbd6fbffb2283cee",
                "id": _searchController.text
              }, (data) async {
                await Provide.value<SFZCXProvide>(context)
                    .setVal(data["showapi_res_body"]["retData"]);
              });
            }),
            _sfzMess()
          ],
        ));
  }

  Widget _sfzMess() {
    return Provide<SFZCXProvide>(builder: (context, child, val) {
      sfzData = Provide.value<SFZCXProvide>(context).dataList;

      if (sfzData["sex"] == "M") {
        sex = "男";
      } else if (sfzData["sex"] == "F") {
        sex = "女";
      } else {
        sex = "";
      }

      return Container(
        margin: EdgeInsets.only(left: 40.w, right: 40.w),
        padding: EdgeInsets.all(40.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.w), color: Colors.white),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('生日：'),
                Text(sfzData["birthday"] ?? ""),
              ],
            ),
            SizedBox(
              height: 20.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('性别：'),
                Text(sex),
              ],
            ),
            SizedBox(
              height: 20.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('身份证所在地：'),
                Text(sfzData["address"] ?? ""),
              ],
            ),
          ],
        ),
      );
    });
  }
}
