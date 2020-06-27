import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import 'package:toolbag/config/common.dart';
import 'package:toolbag/provide/zgjm.dart';

class ZGJM extends StatefulWidget {
  Map arguments;
  ZGJM({this.arguments});

  @override
  _ZGJMState createState() => _ZGJMState();
}

class _ZGJMState extends State<ZGJM> {
  ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  List zgjmDataList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        Provide.value<ZGJMProvide>(context).addPage();
        _getHttp(context, widget.arguments["url"], {
          "showapi_appid": "163969",
          "showapi_sign": "75eb02a80a8e41c0b746bac893fc8a3f",
          "keyWords": _searchController.text,
          "page": Provide.value<ZGJMProvide>(context).page
        });
      }
    });
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
              widget.arguments["title"],
              style: myTextStyle(38, 0xffffffff, false),
            )),
        body: RefreshIndicator(
          onRefresh: _onRefresh,
          child: ListView(
            controller: _scrollController,
            padding: EdgeInsets.only(top: 15.w),
            children: <Widget>[
              searchTitle(context, _searchController, "请输入解梦关键词搜索", () {
                _getHttp(context, widget.arguments["url"], {
                  "showapi_appid": "163969",
                  "showapi_sign": "75eb02a80a8e41c0b746bac893fc8a3f",
                  "keyWords": _searchController.text,
                  "page": Provide.value<ZGJMProvide>(context).page
                });
              }),
              _zgjmContent()
            ],
          ),
        ));
  }

  Widget _zgjmContent() {
    return Provide<ZGJMProvide>(builder: (context, child, val) {
      zgjmDataList = Provide.value<ZGJMProvide>(context).dataList;
      return Column(
        children: zgjmDataList.map((item) {
          return Container(
            margin: EdgeInsets.only(
                left: 40.w, right: 40.w, top: 15.w, bottom: 15.w),
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15.w)),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding: EdgeInsets.only(bottom: 20.w),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 1.w, color: Color(0xff999999)))),
                  child: Text(
                    item["name"],
                    style: myTextStyle(34, 0xff333333, true),
                  ),
                ),
                _detailContent(item["detailList"])
              ],
            ),
          );
        }).toList(),
      );
    });
  }

  Widget _detailContent(List item) {
    return ListView.separated(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: item.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(top: 15.w, bottom: 15.w),
          child: Text(
            item[index],
            style: myTextStyle(30, 0xff666666, false),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Container(height: 1.w, color: Color(0xffcccccc));
      },
    );
  }

  Future _onRefresh() async {
    await Provide.value<ZGJMProvide>(context).initPage();
    print(Provide.value<ZGJMProvide>(context).page);
    await _getHttp(context, widget.arguments["url"], {
      "showapi_appid": "163969",
      "showapi_sign": "75eb02a80a8e41c0b746bac893fc8a3f",
      "keyWords": _searchController.text,
      "page": Provide.value<ZGJMProvide>(context).page
    });
  }

  Future _getHttp(BuildContext context, String url, Map formData) async {
    try {
      Response response;
      Dio dio = new Dio();
      dio.options.contentType =
          ContentType.parse("application/x-www-form-urlencoded").toString();
      response = await dio.post(url, data: formData);
      if (response.statusCode == 200) {
        if (response.data["showapi_res_body"]["contentlist"].length > 0) {
          print(response.data["showapi_res_body"]["contentlist"]);
          await Provide.value<ZGJMProvide>(context)
              .setVal(response.data["showapi_res_body"]["contentlist"]);
        } else {
          shortToast("没数据了......");
        }

        return "完成加载";
      } else {
        throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
      }
    } catch (e) {
      shortToast("接口异常,请明天再尝试！");
    }
  }
}
