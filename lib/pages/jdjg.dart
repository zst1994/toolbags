import 'dart:io';

import 'package:dio/dio.dart';
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
                auLastDate = Provide.value<JDJGProvide>(context).auLastDate;
                goldPrice = Provide.value<JDJGProvide>(context).goldPrice;

                return InkWell(
                    onTap: () {
                      JhPickerTool.showStringPicker(context,
                          data: jdjgDataList, normalIndex: 0, title: "选择金店参考价格",
                          clickCallBack: (int index, var str) {
                        print(Provide.value<JDJGProvide>(context)
                            .newIdList[checkDataIndex]);

                        print(jdjgDataList[checkDataIndex]);
                        Provide.value<JDJGProvide>(context).setIndex(index);
                        Provide.value<JDJGProvide>(context).checkGlobalPrice(
                            context, "https://route.showapi.com/2145-2", {
                          "showapi_appid": "164610",
                          "showapi_sign": "ba353723012c455896e4d91bfa1a3b45",
                          "id": Provide.value<JDJGProvide>(context)
                              .newIdList[checkDataIndex]
                        });
                      });
                    },
                    child: Container(
                      height: 200.h,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                          )
                        ],
                      ),
                    ));
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
        return "完成加载";
      } else {
        throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
      }
    } catch (e) {
      shortToast("接口异常,请明天再尝试！");
    }
  }
}
