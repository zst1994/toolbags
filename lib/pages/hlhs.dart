import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import 'package:toolbag/config/common.dart';
import 'package:toolbag/provide/hlhs.dart';

class HLHS extends StatelessWidget {
  Map arguments;
  HLHS({this.arguments});
  TextEditingController editingController = TextEditingController();
  List hlhsList = [];
  List hlhsListFirst = [];
  List hlhsListSecond = [];
  List newHlhsDataList;
  List checkDataList;
  String hlTitle;

  @override
  Widget build(BuildContext context) {
    Provide.value<HLHSProvide>(context).setMoney("");
    Provide.value<HLHSProvide>(context).setCheckVal(["印尼卢比:IDR", "印尼卢比:IDR"]);

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
            backgroundColor: Color(0xff09abf7),
            title: Text(
              arguments["title"],
              style: myTextStyle(38, 0xffffffff, false),
            )),
        body: FutureBuilder(
            future: _getHttp(context, arguments["url"], {
              "showapi_appid": "163854",
              "showapi_sign": "8cbeef1c2ec1486ea6957d1cffb25954",
            }),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Provide<HLHSProvide>(builder: (context, child, val) {
                  newHlhsDataList =
                      Provide.value<HLHSProvide>(context).dataList;
                  checkDataList =
                      Provide.value<HLHSProvide>(context).checkDataList;
                  return Stack(children: <Widget>[
                    Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1.w,
                                          color: Color(0xff999999)))),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            left: 40.w,
                                            top: 40.w,
                                            bottom: 40.w),
                                        child: Text(checkDataList[0]),
                                      )),
                                  Expanded(
                                    flex: 1,
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxHeight: 80.h,
                                      ),
                                      child: TextField(
                                          autofocus: false,
                                          enableInteractiveSelection: false,
                                          controller: editingController,
                                          keyboardType: TextInputType.number,
                                          textInputAction: TextInputAction.done,
                                          textAlign: TextAlign.end,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(right: 40.w),
                                            hintText: '请输入转换金额',
                                            hintStyle: myTextStyle(
                                                26, 0xff999999, false),
                                            filled: true,
                                            fillColor: Color(0xffffffff),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide.none),
                                          ),
                                          onEditingComplete: () {
                                            _getHLHSContent(
                                                context,
                                                "https://route.showapi.com/105-31",
                                                {
                                                  "showapi_appid": "163854",
                                                  "showapi_sign":
                                                      "8cbeef1c2ec1486ea6957d1cffb25954",
                                                  "fromCode": Provide.value<
                                                          HLHSProvide>(context)
                                                      .checkDataList[0]
                                                      .toString()
                                                      .split(":")[1],
                                                  "toCode": Provide.value<
                                                          HLHSProvide>(context)
                                                      .checkDataList[1]
                                                      .toString()
                                                      .split(":")[1],
                                                  "money":
                                                      editingController.text
                                                });
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                          }),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 40.w, top: 40.w, bottom: 40.w),
                                    child: Text(checkDataList[1]),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                        padding: EdgeInsets.only(right: 40.w),
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          Provide.value<HLHSProvide>(context)
                                              .changeMoney,
                                          style:
                                              myTextStyle(32, 0xff333333, true),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ],
                        )),
                    Align(
                      alignment: Alignment(-1, 1),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Container(
                                height: 400.h,
                                child: CupertinoPicker(
                                  diameterRatio: 1.5,
                                  offAxisFraction: 0.2, //轴偏离系数
                                  magnification: 1.2, //当前选中item放大倍数
                                  itemExtent: 80.h, //行高
                                  squeeze: 1.1,
                                  backgroundColor: Colors.white, //选中器背景色
                                  onSelectedItemChanged: (value) {
                                    checkDataList[0] = newHlhsDataList[value];
                                    Provide.value<HLHSProvide>(context)
                                        .setCheckVal(checkDataList);
                                  },
                                  children: newHlhsDataList.map((data) {
                                    return Center(
                                      child: Text(
                                        data,
                                        style:
                                            myTextStyle(34, 0xff333333, true),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              )),
                          Expanded(
                              flex: 1,
                              child: Container(
                                height: 400.h,
                                child: CupertinoPicker(
                                  diameterRatio: 1.5,
                                  offAxisFraction: 0.2, //轴偏离系数
                                  magnification: 1.2, //当前选中item放大倍数
                                  itemExtent: 80.h, //行高
                                  squeeze: 1.1,
                                  backgroundColor: Colors.white, //选中器背景色
                                  onSelectedItemChanged: (value) {
                                    checkDataList[1] = newHlhsDataList[value];
                                    Provide.value<HLHSProvide>(context)
                                        .setCheckVal(checkDataList);
                                  },
                                  children: newHlhsDataList.map((data) {
                                    return Center(
                                      child: Text(
                                        data,
                                        style:
                                            myTextStyle(34, 0xff333333, true),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ))
                        ],
                      ),
                    ),
                  ]);
                });
              } else {
                return getAnaimation();
              }
            }));
  }

  Future _getHttp(BuildContext context, String url, Map formData) async {
    try {
      Response response;
      Dio dio = new Dio();
      dio.options.contentType =
          ContentType.parse("application/x-www-form-urlencoded").toString();
      response = await dio.post(url, data: formData);
      if (response.statusCode == 200) {
        response.data["showapi_res_body"].forEach((k, v) {
          if (v is String) {
            hlTitle = k + ":" + v;
            print(k + ":" + v);
            hlhsListFirst.add(hlTitle);
            // hlhsListSecond.add(hlTitle);
          }
        });
        // hlhsList.add(hlhsListFirst);
        // hlhsList.add(hlhsListSecond);
        print(hlhsList);
        await Provide.value<HLHSProvide>(context).setVal(hlhsListFirst);
        return "完成加载";
      } else {
        throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
      }
    } catch (e) {
      shortToast("接口异常,请明天再尝试！");
    }
  }

  Future _getHLHSContent(BuildContext context, String url, Map formData) async {
    try {
      Response response;
      Dio dio = new Dio();
      dio.options.contentType =
          ContentType.parse("application/x-www-form-urlencoded").toString();
      response = await dio.post(url, data: formData);
      if (response.statusCode == 200) {
        await Provide.value<HLHSProvide>(context)
            .setMoney(response.data["showapi_res_body"]["money"]);
        return "完成加载";
      } else {
        throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
      }
    } catch (e) {
      shortToast("接口异常,请明天再尝试！");
    }
  }
}
