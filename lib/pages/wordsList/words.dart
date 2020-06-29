import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import 'package:toolbag/config/common.dart';
import 'package:toolbag/provide/bdc.dart';

class WordsPage extends StatefulWidget {
  Map arguments;
  WordsPage({this.arguments});
  @override
  _WordsPageState createState() => _WordsPageState();
}

class _WordsPageState extends State<WordsPage> {
  List wordsDataList;
  ScrollController _scrollController;
  AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Provide.value<BDCProvide>(context).initWordsList();

    return Scaffold(
      backgroundColor: Color(0xfff3f3f3),
      appBar: AppBar(
          elevation: 0.0,
          leading: IconButton(
              icon: Image.asset(
                'images/fanhui_01@2x.png',
                width: 18.w,
              ),
              onPressed: () => Navigator.pop(context,"true"),),
          centerTitle: true,
          backgroundColor: Color(0xff09abf7),
          title: Text(
            widget.arguments["title"],
            style: myTextStyle(38, 0xffffffff, false),
          )),
      body: FutureBuilder(
          future: _getHttp(context, "https://route.showapi.com/8-10", {
            "showapi_appid": "175397",
            "showapi_sign": "8b1d37c0b5a0423ea258a1b2450ebf8d",
            "class_id": widget.arguments["class_id"],
            "course": Provide.value<BDCProvide>(context).course
          }),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Provide<BDCProvide>(builder: (context, child, val) {
                wordsDataList = Provide.value<BDCProvide>(context).wordsList;

                return RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: ListView(
                      controller: _scrollController,
                      padding: EdgeInsets.only(top: 15.w),
                      children: wordsDataList.map((item) {
                        return Container(
                          padding: EdgeInsets.fromLTRB(20.w, 40.w, 20.w, 40.w),
                          margin: EdgeInsets.fromLTRB(40.w, 15.w, 40.w, 15.w),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.w)),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(item["name"]),
                                  Text(item["symbol"])
                                ],
                              ),
                              SizedBox(
                                height: 40.w,
                              ),
                              Divider(
                                height: 1.w,
                                color: Color(0xffcccccc),
                              ),
                              SizedBox(
                                height: 40.w,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(flex: 4, child: Text(item["desc"])),
                                  InkWell(
                                    onTap: () {
                                      audioPlayer.play(item["sound"]);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(
                                          15.w, 6.w, 15.w, 6.w),
                                      child: Image.asset(
                                        "images/yy.png",
                                        width: 40.w,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ));
              });
            } else {
              return getAnaimation();
            }
          }),
    );
  }

  Future _onRefresh() async {
    await Provide.value<BDCProvide>(context).initCourse();
    // print(Provide.value<BDCProvide>(context).page);
    await _getHttp(context, "https://route.showapi.com/8-10", {
      "showapi_appid": "175397",
      "showapi_sign": "8b1d37c0b5a0423ea258a1b2450ebf8d",
      "class_id": widget.arguments["class_id"],
      "course": Provide.value<BDCProvide>(context).course
    });
  }

  Future _getMore() async {
    await Provide.value<BDCProvide>(context).addCourse();
    await _getHttp(context, "https://route.showapi.com/8-10", {
      "showapi_appid": "175397",
      "showapi_sign": "8b1d37c0b5a0423ea258a1b2450ebf8d",
      "class_id": widget.arguments["class_id"],
      "course": Provide.value<BDCProvide>(context).course
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
        if (response.data["showapi_res_body"]["list"].length > 0) {
          await Provide.value<BDCProvide>(context)
              .setWordsList(response.data["showapi_res_body"]["list"]);
        } else {
          shortToast("没有数据了......");
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
