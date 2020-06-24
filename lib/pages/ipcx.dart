import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import 'package:toolbag/config/common.dart';
import 'package:toolbag/provide/ipcx.dart';

class IPCX extends StatelessWidget {
  Map arguments;
  IPCX({this.arguments});
  final TextEditingController _searchController = TextEditingController();
  Map ipcxDataList;

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
            searchTitle(context, _searchController, "请输入ip地址查询(例:172.0.0.1)",
                () {
              _getHttp(context, arguments["url"], {
                "showapi_appid": "164263",
                "showapi_sign": "8ed2e75d5ce543d1beaad4f1d73d7a06",
                "ip": _searchController.text
              });
            }),
            _ipMess()
          ],
        ));
  }

  Widget _ipMess() {
    return Provide<IPCXProvide>(builder: (context, child, val) {
      ipcxDataList = Provide.value<IPCXProvide>(context).dataList;

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
                Text('ip地址：'),
                Text(ipcxDataList["ip"] ?? ""),
              ],
            ),
            SizedBox(
              height: 20.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('片区：'),
                Text(ipcxDataList["continents"] ?? ""),
              ],
            ),
            SizedBox(
              height: 20.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('国家：'),
                Text(ipcxDataList["country"] ?? ""),
              ],
            ),
            SizedBox(
              height: 20.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('省份：'),
                Text(ipcxDataList["region"] ?? ""),
              ],
            ),
            SizedBox(
              height: 20.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('市级：'),
                Text(ipcxDataList["city"] ?? ""),
              ],
            ),
            SizedBox(
              height: 20.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('区县：'),
                Text(ipcxDataList["county"] ?? ""),
              ],
            ),
            SizedBox(
              height: 20.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('城市编码：'),
                Text(ipcxDataList["city_code"] ?? ""),
              ],
            ),
            SizedBox(
              height: 20.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('运营商：'),
                Text(ipcxDataList["isp"] ?? ""),
              ],
            ),
            SizedBox(
              height: 20.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('经度：'),
                Text(ipcxDataList["lnt"] ?? ""),
              ],
            ),
            SizedBox(
              height: 20.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('维度：'),
                Text(ipcxDataList["lat"] ?? ""),
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
      await Provide.value<IPCXProvide>(context)
          .setVal(response.data["showapi_res_body"]);
      return "完成加载";
    } catch (e) {
      shortToast("接口异常,请明天再尝试！");
    }
  }
}
