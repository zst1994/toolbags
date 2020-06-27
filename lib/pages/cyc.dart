import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import 'package:toolbag/config/common.dart';
import 'package:toolbag/provide/cyc.dart';

class CYC extends StatelessWidget {
  Map arguments;
  CYC({this.arguments});
  List _cycList;
  List cycDataList;

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
            "showapi_appid": "168071",
            "showapi_sign": "b170d2ee39d94917a707e201abe1e48a",
          }),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Provide<CYCProvide>(builder: (context, child, val) {
                cycDataList = Provide.value<CYCProvide>(context).dataList;
                return ListView(
                  padding: EdgeInsets.only(top: 15.w),
                  children: cycDataList.map((item) {
                    return _cycContent(context, item);
                  }).toList(),
                );
              });
            } else {
              return getAnaimation();
            }
          }),
    );
  }

  Widget _cycContent(BuildContext context, Map item) {
    return InkWell(
      onTap: () {
        if (item["open"]) {
          item["open"] = false;
        } else {
          item["open"] = true;
        }
        Provide.value<CYCProvide>(context).setVal(cycDataList);
      },
      child: Container(
        margin:
            EdgeInsets.only(left: 40.w, right: 40.w, top: 15.w, bottom: 15.w),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15.w)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 20.w),
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(width: 1.w, color: Color(0xffcccccc)))),
              child: Text(item["typeName"]),
            ),
            SizedBox(height: 20.w),
            Text(
              item["title"],
              style: myTextStyle(32, 0xff333333, false),
            ),
            SizedBox(height: 20.w),
            Divider(
              height: 1.w,
              color: Color(0xffcccccc),
            ),
            SizedBox(height: 20.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '谜底：',
                  style: myTextStyle(30, 0xff666666, false),
                ),
                Expanded(
                    flex: 1,
                    child: item["open"]
                        ? Text(
                            item["answer"].toString().split("：")[1],
                            style: myTextStyle(30, 0xff666666, false),
                            textAlign: TextAlign.center,
                          )
                        : Text(""))
              ],
            )
          ],
        ),
      ),
    );
  }

  Future _getHttp(BuildContext context, String url, Map formData) async {
    // await Provide.value<CYCProvide>(context).setVal([]);
    try {
      Response response;
      Dio dio = new Dio();
      dio.options.contentType =
          ContentType.parse("application/x-www-form-urlencoded").toString();
      response = await dio.post(url, data: formData);
      if (response.statusCode == 200) {
        print(response.data);

        _cycList = response.data["showapi_res_body"]["pagebean"]["contentlist"];
        _cycList.forEach((item) {
          item.addAll({"open": false});
        });

        await Provide.value<CYCProvide>(context).setVal(_cycList);
        return "完成加载";
      } else {
        throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
      }
    } catch (e) {
      shortToast("接口异常,请明天再尝试！");
    }
  }
}
