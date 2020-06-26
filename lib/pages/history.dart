import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import 'package:toolbag/config/common.dart';
import 'package:toolbag/provide/history.dart';

class HISTORY extends StatelessWidget {
  Map arguments;
  HISTORY({this.arguments});
  final TextEditingController _searchController = TextEditingController();
  List historyDataList;

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
              "showapi_appid": "164354",
              "showapi_sign": "71cfda0a91e44e70aac5de5f1951e496",
              "date": ""
            }),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  padding: EdgeInsets.only(top: 15.w),
                  children: <Widget>[
                    searchTitle(
                        context, _searchController, "请输入时间查询：0101(月份日期)", () {
                      _getHttp(context, arguments["url"], {
                        "showapi_appid": "164354",
                        "showapi_sign": "71cfda0a91e44e70aac5de5f1951e496",
                        "date": _searchController.text
                      });
                    }),
                    _historyContent()
                  ],
                );
              } else {
                return getAnaimation();
              }
            }));
  }

  Widget _historyContent() {
    return Provide<HistoryProvide>(builder: (context, child, val) {
      historyDataList = Provide.value<HistoryProvide>(context).dataList;
      return Column(
        children: historyDataList.map((item) {
          return _hisContent(item);
        }).toList(),
      );
    });
  }

  Widget _hisContent(Map item) {
    print(item["img"]);
    return Container(
      margin: EdgeInsets.only(left: 40.w, right: 40.w, top: 15.w, bottom: 15.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15.w)),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                  flex: 4,
                  child: Text(
                    item["title"],
                    style: myTextStyle(32, 0xff333333, true),
                  )),
              Expanded(
                  flex: 2,
                  child: Text(
                    item["year"] +
                        "-" +
                        item["month"].toString() +
                        "-" +
                        item["day"].toString(),
                    textAlign: TextAlign.right,
                    style: myTextStyle(28, 0xff999999, false),
                  ))
            ],
          ),
          item["img"] != null
              ? Container(
                  padding: EdgeInsets.all(15.w),
                  child: Image.network(
                    item["img"],
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  Future _getHttp(BuildContext context, String url, Map formData) async {
    await Provide.value<HistoryProvide>(context).setVal([]);
    try {
      Response response;
      Dio dio = new Dio();
      dio.options.contentType =
          ContentType.parse("application/x-www-form-urlencoded").toString();
      response = await dio.post(url, data: formData);
      if (response.statusCode == 200) {
        print(response.data);
        await Provide.value<HistoryProvide>(context)
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
