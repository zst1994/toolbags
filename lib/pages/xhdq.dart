import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import 'package:toolbag/config/common.dart';
import 'package:toolbag/provide/xhdq.dart';

class XHDQ extends StatelessWidget {
  Map arguments;
  XHDQ({this.arguments});
  List xhDataList;

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
        body: FutureBuilder(
            future: _getHttp(context, arguments["url"], {
              "showapi_appid": "163892",
              "showapi_sign": "2bf78728c6344e559f159871f2fb7ead",
              "len": 100
            }),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Provide<XHProvide>(builder: (context, child, val) {
                  xhDataList = Provide.value<XHProvide>(context).dataList;
                  return ListView(
                    children: xhDataList.map((item) {
                      return _xhContent(item);
                    }).toList(),
                  );
                });
              } else {
                return getAnaimation();
              }
            }));
  }

  Widget _xhContent(Map item) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20.w)),
      margin: EdgeInsets.only(left: 40.w, right: 40.w, top: 30.w),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            padding: EdgeInsets.only(top: 25.w, bottom: 25.w),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1.w, color: Color(0xffcccccc)))),
            child: Text('分享20个冷笑话，让你笑得停不下来'),
          ),
          Container(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.w),
            child: Html(
              data: item["text"],
            ),
          )
        ],
      ),
    );
  }

  Future _getHttp(BuildContext context, String url, Map formData) async {
    await Provide.value<XHProvide>(context).setVal([]);
    try {
      Response response;
      Dio dio = new Dio();
      dio.options.contentType =
          ContentType.parse("application/x-www-form-urlencoded").toString();
      response = await dio.post(url, data: formData);
      if (response.statusCode == 200) {
        print(response.data);
        await Provide.value<XHProvide>(context)
            .setVal(response.data["showapi_res_body"]["list"]);
        return "完成加载";
      } else {
        throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
      }
    } catch (e) {
      shortToast("接口异常,请明天再尝试！");
    }
  }
}
