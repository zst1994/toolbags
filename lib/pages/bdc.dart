import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import 'package:toolbag/config/common.dart';
import 'package:toolbag/provide/bdc.dart';

class BDC extends StatelessWidget {
  Map arguments;
  BDC({this.arguments});
  final TextEditingController _searchController = TextEditingController();
  FixedExtentScrollController cuperScrollController =
      FixedExtentScrollController();
  List bdcDataList;
  int checkIndex;

  @override
  Widget build(BuildContext context) {
    Provide.value<BDCProvide>(context).initVal();
    Provide.value<BDCProvide>(context).setSubIndex(0);

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
            backgroundColor: Theme.of(context).accentColor,
            title: Text(
              arguments["title"],
              style: myTextStyle(38, 0xffffffff, false),
            )),
        body: FutureBuilder(
            future: getHttp(context, arguments["url"], {
              "showapi_appid": "175397",
              "showapi_sign": "8b1d37c0b5a0423ea258a1b2450ebf8d",
            }, (data) async {
              await Provide.value<BDCProvide>(context)
                  .setVal(data["showapi_res_body"]["typeList"]);
            }),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Provide<BDCProvide>(builder: (context, child, val) {
                  bdcDataList = Provide.value<BDCProvide>(context).dataList;
                  checkIndex = Provide.value<BDCProvide>(context).index;
                  _searchController.text = bdcDataList[checkIndex]["child_list"]
                      [Provide.value<BDCProvide>(context).subIndex]["title"];
                  return Stack(children: <Widget>[
                    Align(
                        alignment: Alignment.topCenter,
                        child: ListView(
                          children: <Widget>[
                            searchTitle(context, _searchController, "请选择类型",
                                () {
                              Provide.value<BDCProvide>(context)
                                  .initWordsList();
                              Navigator.pushNamed<dynamic>(context, "/words",
                                      arguments: bdcDataList[checkIndex]
                                              ["child_list"][
                                          Provide.value<BDCProvide>(context)
                                              .subIndex])
                                  .then((dynamic value) {
                                //处理代码
                                cuperScrollController.jumpTo(0.0);
                              });
                            })
                          ],
                        )),
                    Align(
                      alignment: Alignment(-1, 1),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              flex: 3,
                              child: Container(
                                height: 400.h,
                                child: CupertinoPicker(
                                  scrollController: cuperScrollController,
                                  diameterRatio: 1.5,
                                  offAxisFraction: 0.2, //轴偏离系数
                                  magnification: 1.2, //当前选中item放大倍数
                                  itemExtent: 80.h, //行高
                                  squeeze: 1.1,
                                  backgroundColor: Colors.white, //选中器背景色
                                  onSelectedItemChanged: (value) {
                                    Provide.value<BDCProvide>(context)
                                        .setValue(value);
                                  },
                                  children: bdcDataList.map((data) {
                                    return Center(
                                      child: Text(
                                        data["title"],
                                        style:
                                            myTextStyle(30, 0xff333333, true),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              )),
                          Expanded(
                              flex: 4,
                              child: Container(
                                height: 400.h,
                                child: CupertinoPicker(
                                  scrollController: cuperScrollController,
                                  diameterRatio: 1.5,
                                  offAxisFraction: 0.2, //轴偏离系数
                                  magnification: 1.2, //当前选中item放大倍数
                                  itemExtent: 80.h, //行高
                                  squeeze: 1.1,
                                  backgroundColor: Colors.white, //选中器背景色
                                  onSelectedItemChanged: (value) {
                                    Provide.value<BDCProvide>(context)
                                        .setSubIndex(value);
                                    _searchController.text =
                                        bdcDataList[checkIndex]["child_list"]
                                            [value]["title"];
                                  },
                                  children: (bdcDataList[checkIndex]
                                          ["child_list"] as List)
                                      .cast()
                                      .map((data) {
                                    return Center(
                                      child: Text(
                                        data["title"],
                                        style:
                                            myTextStyle(30, 0xff333333, true),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ))
                        ],
                      ),
                    )
                  ]);
                });
              } else {
                return getAnaimation();
              }
            }));
  }
}
