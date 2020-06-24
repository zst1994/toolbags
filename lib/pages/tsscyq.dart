import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import 'package:toolbag/config/common.dart';
import 'package:toolbag/provide/tssc.dart';

//唐诗宋词元曲
class TSSC extends StatefulWidget {
  Map arguments;
  TSSC({Key key, this.arguments}) : super(key: key);

  @override
  _TSSCState createState() => _TSSCState();
}

class _TSSCState extends State<TSSC> {
  ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  List<Map> data;
  List prelist = [
    "李白",
    "杜甫",
    "苏轼",
    "王居易",
    "王安石",
  ];

  @override
  void initState() {
    super.initState();
    String author = prelist[Random().nextInt(prelist.length)];
    _getHttp(context, widget.arguments["url"], {
      "showapi_appid": "163751",
      "showapi_sign": "64e0f205797744a08876bc926732c373",
      "poet": author
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
              widget.arguments["title"],
              style: myTextStyle(38, 0xffffffff, false),
            )),
        body: RefreshIndicator(
          onRefresh: _onRefresh,
          child: ListView(
            controller: _scrollController,
            children: <Widget>[
              searchTitle(context, _searchController, "请输入作者名称搜索", () {
                _getHttp(context, widget.arguments["url"], {
                  "showapi_appid": "163751",
                  "showapi_sign": "64e0f205797744a08876bc926732c373",
                  "poet": _searchController.text
                });
              }),
              _scContent()
            ],
          ),
        ));
  }

  Widget _scContent() {
    return Provide<TSSCProvide>(builder: (context, child, val) {
      data = Provide.value<TSSCProvide>(context).dataList;
      if (data.length > 0) {
        return Column(
          children: data.map((item) {
            return Container(
              width: 670.w,
              margin: EdgeInsets.only(bottom: 40.w),
              padding: EdgeInsets.all(40.w),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.w)),
              child: Column(
                children: <Widget>[
                  Text(
                    item["title"],
                    style: myTextStyle(34, 0xff333333, true),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 6.w, bottom: 6.w),
                    child: Text.rich(TextSpan(children: [
                      TextSpan(
                          text: item["dynasty"],
                          style: myTextStyle(28, 0xff666666, false)),
                      TextSpan(
                          text: "：", style: myTextStyle(28, 0xff666666, false)),
                      TextSpan(
                          text: item["poet"],
                          style: myTextStyle(28, 0xff666666, false)),
                    ])),
                  ),
                  Column(
                    children: (item["contentlist"] as List).map((val) {
                      return Container(
                        padding: EdgeInsets.only(top: 6.w, bottom: 6.w),
                        child: Text(
                          val["original"],
                          style: myTextStyle(30, 0xff333333, false),
                        ),
                      );
                    }).toList(),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(top: 6.w, bottom: 6.w),
                    child: Text(
                      '译文：',
                      style: myTextStyle(32, 0xff000000, true),
                    ),
                  ),
                  Column(
                    children: (item["contentlist"] as List).map((val) {
                      return Container(
                        padding: EdgeInsets.only(top: 6.w, bottom: 6.w),
                        child: Text(
                          val["translation"],
                          style: myTextStyle(30, 0xff666666, false),
                        ),
                      );
                    }).toList(),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(top: 6.w, bottom: 6.w),
                    child: Text(
                      '注释：',
                      style: myTextStyle(32, 0xff000000, true),
                    ),
                  ),
                  Column(
                    children: (item["contentlist"] as List).map((val) {
                      return Container(
                        padding: EdgeInsets.only(top: 6.w, bottom: 6.w),
                        child: Text(
                          val["annotation"],
                          style: myTextStyle(30, 0xff666666, false),
                        ),
                      );
                    }).toList(),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(top: 6.w, bottom: 6.w),
                    child: Text(
                      '作者简介：',
                      style: myTextStyle(32, 0xff000000, true),
                    ),
                  ),
                  Container(
                    child: Text(
                      Provide.value<TSSCProvide>(context).biography,
                      style: myTextStyle(30, 0xff666666, false),
                    ),
                  )
                ],
              ),
            );
          }).toList(),
        );
      } else {
        return getAnaimation();
      }
    });
  }

  Future _onRefresh() async {
    await Provide.value<TSSCProvide>(context).initPage();
    print(Provide.value<TSSCProvide>(context).page);
    await Provide.value<TSSCProvide>(context).getTSContent();
  }

  Future _getMore() async {
    await Provide.value<TSSCProvide>(context).addPage();
    print(Provide.value<TSSCProvide>(context).page);
    await Provide.value<TSSCProvide>(context).getTSContent();
  }

  Future _getHttp(BuildContext context, String url, Map formData) async {
    print(formData);
    // await Provide.value<TSSCProvide>(context).initDataList();
    try {
      Response response;
      Dio dio = new Dio();
      dio.options.contentType =
          ContentType.parse("application/x-www-form-urlencoded").toString();
      response = await dio.post(url, data: formData);

      String poetId =
          response.data["showapi_res_body"]["poetInfo"][0]["poetId"];
      String biography =
          response.data["showapi_res_body"]["poetInfo"][0]["biography"];
      print(poetId);
      print(biography);
      await Provide.value<TSSCProvide>(context).setVal(poetId, biography);
      await Provide.value<TSSCProvide>(context).getTSContent();

      return "完成加载";
    } catch (e) {
      shortToast("接口异常,请明天再尝试！");
    }
  }
}
//唐诗宋词元曲
