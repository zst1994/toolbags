import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import 'package:toolbag/config/common.dart';
import 'package:toolbag/provide/jryj.dart';

class JRYJ extends StatelessWidget {
  Map arguments;
  JRYJ({this.arguments});
  final TextEditingController _searchController = TextEditingController();
  Map jryjDataList;

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
            searchTitle(context, _searchController, "请输入省份查询油价(例：广东)", () {
              _getHttp(context, arguments["url"], {
                "showapi_appid": "164572",
                "showapi_sign": "0c5ee55884604b469d8db50f7519b73b",
                "prov": _searchController.text
              });
            }),
            _yjMess()
          ],
        ));
  }

  Widget _yjMess() {
    return Provide<JRYJProvide>(builder: (context, child, val) {
      jryjDataList = Provide.value<JRYJProvide>(context).dataList;
      
      String time = jryjDataList["ct"] ?? "";
      if (time.length > 0) {
        time = time.substring(0, 19);
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
                Text('省份：'),
                Text(jryjDataList["prov"] ?? ""),
              ],
            ),
            SizedBox(
              height: 20.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('90号汽油：'),
                Text(jryjDataList["p90"] ?? ""),
              ],
            ),
            SizedBox(
              height: 20.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('93号汽油：'),
                Text(jryjDataList["p93"] ?? ""),
              ],
            ),
            SizedBox(
              height: 20.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('97号汽油：'),
                Text(jryjDataList["p97"] ?? ""),
              ],
            ),
            SizedBox(
              height: 20.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('0号柴油：'),
                Text(jryjDataList["p0"] ?? ""),
              ],
            ),
            SizedBox(
              height: 20.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('89号汽油：'),
                Text(jryjDataList["p89"] ?? ""),
              ],
            ),
            SizedBox(
              height: 20.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('92号汽油：'),
                Text(jryjDataList["p92"] ?? ""),
              ],
            ),
            SizedBox(
              height: 20.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('95号汽油：'),
                Text(jryjDataList["p95"] ?? ""),
              ],
            ),
            SizedBox(
              height: 20.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('98号汽油：'),
                Text(jryjDataList["p98"] ?? ""),
              ],
            ),
            SizedBox(
              height: 20.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('更新时间：'),
                Text(time),
              ],
            ),
          ],
        ),
      );
    });
  }

  Future _getHttp(BuildContext context, String url, Map formData) async {
    try {
      Response response;
      Dio dio = new Dio();
      dio.options.contentType =
          ContentType.parse("application/x-www-form-urlencoded").toString();
      response = await dio.post(url, data: formData);
      await Provide.value<JRYJProvide>(context)
          .setVal(response.data["showapi_res_body"]["list"][0]);
      return "完成加载";
    } catch (e) {
      shortToast("接口异常,请明天再尝试！");
    }
  }
}
