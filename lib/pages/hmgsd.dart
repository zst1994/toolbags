import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import 'package:toolbag/config/common.dart';
import 'package:toolbag/provide/hmgsd.dart';

class HMGSD extends StatelessWidget {
  Map arguments;
  HMGSD({this.arguments});
  final TextEditingController _searchController = TextEditingController();
  Map hmgsdDataList;

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
            searchTitle(context, _searchController, "请输入手机号码查询", () {
              _getHttp(context, arguments["url"], {
                "showapi_appid": "164260",
                "showapi_sign": "8bee29c8c2284c61939200ec8e83db8d",
                "num": _searchController.text
              });
            }),
            _hmgsdMess()
          ],
        ));
  }

  Widget _hmgsdMess() {
    return Provide<HMGSDProvide>(builder: (context, child, val) {
      hmgsdDataList = Provide.value<HMGSDProvide>(context).dataList;

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
                Text(hmgsdDataList["prov"] ?? ""),
              ],
            ),
            SizedBox(
              height: 20.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('市级：'),
                Text(hmgsdDataList["city"] ?? ""),
              ],
            ),
            SizedBox(
              height: 20.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('运营商：'),
                Text(hmgsdDataList["name"] ?? ""),
              ],
            ),
            SizedBox(
              height: 20.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('省份编码：'),
                Text(hmgsdDataList["provCode"] ?? ""),
              ],
            ),
            SizedBox(
              height: 20.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('城市编码：'),
                Text(hmgsdDataList["cityCode"] ?? ""),
              ],
            ),
            SizedBox(
              height: 20.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('座机区号：'),
                Text(hmgsdDataList["areaCode"] ?? ""),
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
      await Provide.value<HMGSDProvide>(context)
          .setVal(response.data["showapi_res_body"]);
      return "完成加载";
    } catch (e) {
      shortToast("接口异常,请明天再尝试！");
    }
  }
}
