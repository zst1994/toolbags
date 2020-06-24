import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class TSSCProvide with ChangeNotifier {
  List<Map> dataList = [];
  String poetId;
  String biography;
  int page = 1;

  //搜索按钮
  setVal(String newPoetId,String newBiography) {
    poetId = newPoetId;
    biography = newBiography;
    notifyListeners();
  }

  initPage() {
    page = 1;
    notifyListeners();
  }

  addPage(){
    page++;
    notifyListeners();
  }

  initDataList() {
    dataList = [];
    notifyListeners();
  }

  getTSContent() async {
    try {
      Response newResponse;
      Dio dio = new Dio();
      dio.options.contentType =
          ContentType.parse("application/x-www-form-urlencoded").toString();

      newResponse = await dio.post("https://route.showapi.com/1620-5", data: {
        "showapi_appid": "163751",
        "showapi_sign": "64e0f205797744a08876bc926732c373",
        "poetId": poetId,
        "page": page.toString()
      });

      dataList.addAll((newResponse.data["showapi_res_body"]["poemInfo"] as List).cast());
      notifyListeners();
    } catch (e) {
      return print("eeeeeeeeeee22=$e");
    }
  }
}