import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import 'package:toolbag/config/common.dart';
import 'package:toolbag/provide/yqsscx.dart';

//疫情实时查询

class YQSSCX extends StatelessWidget {
  Map arguments;
  YQSSCX({this.arguments});

  List<Map> list;
  List _yqBottomContentList;
  String updateTime;

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
            future: _getHttp(context, arguments["url"], {}),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(40.w),
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.h),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: <Widget>[
                          _yqTitle(),
                          SizedBox(
                            height: 20.w,
                          ),
                          Divider(
                            height: 1.h,
                            color: Color(0xffcccccc),
                          ),
                          _yqTitleContent()
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 40.w, right: 40.w),
                      // padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.h),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: <Widget>[
                          _yqBottomTitle(),
                          SizedBox(
                            height: 20.w,
                          ),
                          Divider(
                            height: 1.h,
                            color: Color(0xffcccccc),
                          ),
                          _yqBottomWay(),
                          Divider(
                            height: 1.h,
                            color: Color(0xffcccccc),
                          ),
                          _yqBottomContent(),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40.w,
                    ),
                  ],
                );
              } else {
                return getAnaimation();
              }
            }));
  }

  Widget _yqTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          '国内疫情数据',
          style: myTextStyle(30, 0xff09abf7, true),
        ),
        Text(
          '截至北京时间 $updateTime',
          style: myTextStyle(24, 0xff666666, false),
        )
      ],
    );
  }

  Widget _yqTitleContent() {
    return GridView(
        shrinkWrap: true,
        //childAspectRatio  子元素在横轴长度和主轴长度的比例
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: 1.3),
        children: list.map((item) {
          return Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "较昨日",
                        style: myTextStyle(20, 0xff666666, false),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Text(
                        item["todayAdd"] > 0
                            ? "+${item["todayAdd"]}"
                            : item["todayAdd"] == 0
                                ? "无变化"
                                : item["todayAdd"].toString(),
                        style: item["todayAdd"] == 0
                            ? myTextStyle(20, 0xff666666, false)
                            : myTextStyle(20, item["color"], false),
                      ),
                    ],
                  ),
                  Text(
                    item["todayNum"].toString(),
                    style: myTextStyle(45, item["color"], true),
                  ),
                  Text(
                    item["title"],
                    style: myTextStyle(22, 0xff000000, true),
                  )
                ],
              ),
            ),
          );
        }).toList());
  }

  Widget _yqBottomTitle() {
    return Container(
      padding: EdgeInsets.only(top: 20.w),
      alignment: Alignment.center,
      child: Text(
        '国内各地疫情数据',
        style: myTextStyle(30, 0xff09abf7, true),
      ),
    );
  }

  Widget _yqBottomWay() {
    return Container(
      padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: 134.w,
            child: Text(
              '地区',
              style: myTextStyle(26, 0xff333333, false),
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: 134.w,
            child: Text(
              '现存确诊',
              style: myTextStyle(26, 0xff333333, false),
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: 134.w,
            child: Text(
              '累计确诊',
              style: myTextStyle(26, 0xff333333, false),
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: 134.w,
            child: Text(
              '死亡',
              style: myTextStyle(26, 0xff333333, false),
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: 134.w,
            child: Text(
              '治愈',
              style: myTextStyle(26, 0xff333333, false),
            ),
          ),
        ],
      ),
    );
  }

  Widget _yqBottomContent() {
    return Provide<YQSSCXProvide>(builder: (context, child, val) {
      _yqBottomContentList = Provide.value<YQSSCXProvide>(context).dataList;

      return ListView.separated(
        shrinkWrap: true,
        //childAspectRatio  子元素在横轴长度和主轴长度的比例
        physics: NeverScrollableScrollPhysics(),
        itemCount: _yqBottomContentList.length,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                if (_yqBottomContentList[index]["open"]) {
                  _yqBottomContentList[index]["open"] = false;
                } else {
                  _yqBottomContentList[index]["open"] = true;
                }
                Provide.value<YQSSCXProvide>(context)
                    .setVal(_yqBottomContentList);
              },
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          width: 134.w,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SizedBox(
                                width: 6.w,
                              ),
                              _yqBottomContentList[index]["cityList"].length > 0
                                  ? _yqBottomContentList[index]["open"]
                                      ? Image.asset(
                                          "images/down.png",
                                          width: 20.w,
                                        )
                                      : Image.asset(
                                          "images/blue_right.png",
                                          width: 20.w,
                                        )
                                  : Container(
                                      width: 20.w,
                                    ),
                              Container(
                                width: 103.w,
                                child: Text(
                                  _yqBottomContentList[index]["provinceName"],
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: 134.w,
                          alignment: Alignment.center,
                          child: Text(_yqBottomContentList[index]
                                  ["currentConfirmedNum"]
                              .toString()),
                        ),
                        Container(
                          width: 134.w,
                          alignment: Alignment.center,
                          child: Text((_yqBottomContentList[index]
                                      ["currentConfirmedNum"] +
                                  _yqBottomContentList[index]["deadNum"] +
                                  _yqBottomContentList[index]["curedNum"])
                              .toString()),
                        ),
                        Container(
                          width: 134.w,
                          alignment: Alignment.center,
                          child: Text(_yqBottomContentList[index]["deadNum"]
                              .toString()),
                        ),
                        Container(
                          width: 134.w,
                          alignment: Alignment.center,
                          child: Text(_yqBottomContentList[index]["curedNum"]
                              .toString()),
                        ),
                      ],
                    ),
                  ),
                  _yqBottomContentList[index]["open"]
                      ? Divider(
                          height: 1.w,
                          color: Color(0xffcccccc),
                        )
                      : Container(),
                  _yqBottomContentList[index]["open"]
                      ? _cityList(index)
                      : Container()
                ],
              ));
        },
        separatorBuilder: (context, idx) {
          return Divider(
            height: 1.h,
            color: Color(0xffcccccc),
          );
        },
      );
    });
  }

  Widget _cityList(int index) {
    return Column(
      children:
          (_yqBottomContentList[index]["cityList"] as List).cast().map((item) {
        return Container(
          color: Color(0xffdddddd),
          padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                width: 134.w,
                alignment: Alignment.center,
                child: Text(
                  item["cityName"],
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                width: 134.w,
                alignment: Alignment.center,
                child: Text(item["currentConfirmedNum"].toString()),
              ),
              Container(
                width: 134.w,
                alignment: Alignment.center,
                child: Text((item["confirmedNum"]).toString()),
              ),
              Container(
                width: 134.w,
                alignment: Alignment.center,
                child: Text(item["deadNum"].toString()),
              ),
              Container(
                width: 134.w,
                alignment: Alignment.center,
                child: Text(item["curedNum"].toString()),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Future _getHttp(BuildContext context, String url, Map formData) async {
    print(url);
    print(formData);
    try {
      Response response;
      response = await Dio().post(url, data: formData);
      _yqBottomContentList =
          response.data["showapi_res_body"]["todayDetailList"];
      _yqBottomContentList.forEach((item) {
        item.addAll({"open": false});
      });
      Provide.value<YQSSCXProvide>(context).setVal(_yqBottomContentList);

      updateTime = response.data["showapi_res_body"]["updateTime"];
      Map todayStatictic = response.data["showapi_res_body"]["todayStatictic"];
      todayStatictic["curedIncr"] = todayStatictic["curedIncr"] ?? 0;
      todayStatictic["confirmedIncr"] = todayStatictic["confirmedIncr"] ?? 0;
      todayStatictic["suspectedIncr"] = todayStatictic["suspectedIncr"] ?? 0;
      todayStatictic["seriousIncr"] = todayStatictic["seriousIncr"] ?? 0;
      todayStatictic["deadIncr"] = todayStatictic["deadIncr"] ?? 0;

      list = [
        {
          "color": 0xfff76809,
          "title": "现存确诊",
          "todayNum": todayStatictic["confirmedNum"],
          "todayAdd":
              todayStatictic["confirmedIncr"] - todayStatictic["curedIncr"] - todayStatictic["deadIncr"]
        },
        {
          "color": 0xfff7ac09,
          "title": "境外输入",
          "todayNum": todayStatictic["suspectedNum"],
          "todayAdd": todayStatictic["suspectedIncr"]
        },
        {
          "color": 0xffbe6d37,
          "title": "现存无症状",
          "todayNum": todayStatictic["seriousNum"],
          "todayAdd": todayStatictic["seriousIncr"]
        },
        {
          "color": 0xff92410b,
          "title": "累计确诊",
          "todayNum": todayStatictic["curedNum"] +
              todayStatictic["deadNum"] +
              todayStatictic["confirmedNum"],
          "todayAdd": todayStatictic["confirmedIncr"]
        },
        {
          "color": 0xff2d82aa,
          "title": "累计死亡",
          "todayNum": todayStatictic["deadNum"],
          "todayAdd": todayStatictic["deadIncr"]
        },
        {
          "color": 0xff2ed897,
          "title": "累计治愈",
          "todayNum": todayStatictic["curedNum"],
          "todayAdd": todayStatictic["curedIncr"]
        }
      ];
      return list;
    } catch (e) {
      return print("eeeeeeeeeee=$e");
    }
  }
}
//疫情实时查询
