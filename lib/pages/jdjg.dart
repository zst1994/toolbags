import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import 'package:toolbag/config/common.dart';
import 'package:toolbag/provide/jdjg.dart';

class JDJG extends StatefulWidget {
  final Map arguments;
  JDJG({Key key, this.arguments}) : super(key: key);

  @override
  _JDJGState createState() => _JDJGState(arguments: this.arguments);
}

class _JDJGState extends State<JDJG> {
  Map arguments;
  _JDJGState({this.arguments});

  String jdTitle;
  String auLastDate;
  String goldPrice;
  List jdList = [];
  List jdIDList = [];
  List newIdList = [];
  List jdjgDataList;
  int checkDataIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
            "showapi_appid": "164610",
            "showapi_sign": "ba353723012c455896e4d91bfa1a3b45",
          }),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Provide<JDJGProvide>(builder: (context, child, val) {
                jdjgDataList = Provide.value<JDJGProvide>(context).dataList;
                checkDataIndex = Provide.value<JDJGProvide>(context).checkIndex;
                newIdList = Provide.value<JDJGProvide>(context).newIdList;
                auLastDate = Provide.value<JDJGProvide>(context).auLastDate;
                goldPrice = Provide.value<JDJGProvide>(context).goldPrice;

                return Stack(
                  children: <Widget>[
                    Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: 200.h,
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.center,
                                    width: 250.w,
                                    child: Text('珠宝店'),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: 250.w,
                                    child: Text('金价'),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: 250.w,
                                    child: Text('时间'),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 30.w,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.center,
                                    width: 250.w,
                                    child: Text(jdjgDataList[checkDataIndex]),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: 250.w,
                                    child: Text(goldPrice),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: 250.w,
                                    child: Text(auLastDate),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )),
                    Align(
                      alignment: Alignment(-1, 1),
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
                            Provide.value<JDJGProvide>(context).setIndex(value);
                            print(value);
                            Provide.value<JDJGProvide>(context)
                                .checkGlobalPrice(context,
                                    "https://route.showapi.com/2145-2", {
                              "showapi_appid": "164610",
                              "showapi_sign":
                                  "ba353723012c455896e4d91bfa1a3b45",
                              "id": Provide.value<JDJGProvide>(context)
                                  .newIdList[value]
                            });
                          },
                          children: jdjgDataList.map((data) {
                            return Center(
                              child: Text(data),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                );
              });
            } else {
              return getAnaimation();
            }
          }),
    );
  }

  Future _getHttp(BuildContext context, String url, Map formData) async {
    try {
      Response response;
      Dio dio = new Dio();
      dio.options.contentType =
          ContentType.parse("application/x-www-form-urlencoded").toString();
      response = await dio.post(url, data: formData);
      if (response.statusCode == 200) {
        response.data["showapi_res_body"]["data"].forEach((item) {
          jdList.add(item["brand"]);
          jdIDList.add(item["_id"]);
        });

        await Provide.value<JDJGProvide>(context).setVal(jdList, jdIDList);
        await Provide.value<JDJGProvide>(context)
            .checkGlobalPrice(context, "https://route.showapi.com/2145-2", {
          "showapi_appid": "164610",
          "showapi_sign": "ba353723012c455896e4d91bfa1a3b45",
          "id": Provide.value<JDJGProvide>(context).newIdList[0]
        });
        return "完成加载";
      } else {
        throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
      }
    } catch (e) {
      shortToast("接口异常,请明天再尝试！");
    }
  }
}
