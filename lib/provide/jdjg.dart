import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:toolbag/config/common.dart';

class JDJGProvide with ChangeNotifier {
  List dataList = [];
  List newIdList = [];
  int checkIndex = 0;
  String auLastDate = "";
  String goldPrice = "";

  //搜索按钮
  setVal(List data, List idList) {
    dataList = data;
    newIdList = idList;
    notifyListeners();
  }

  setIndex(int index) {
    checkIndex = index;
    notifyListeners();
  }

  checkGlobalPrice(BuildContext context, String url, Map formData) async {
    try {
      Response response;
      Dio dio = new Dio();
      dio.options.contentType =
          ContentType.parse("application/x-www-form-urlencoded").toString();
      response = await dio.post(url, data: formData);
      if (response.statusCode == 200) {
        auLastDate = response.data["showapi_res_body"]["auLastDate"];
        goldPrice = response.data["showapi_res_body"]["goldPrice"].toString();
        print(auLastDate);
        print(goldPrice);
        return "完成加载";
      } else {
        throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
      }
    } catch (e) {
      shortToast("接口异常,请明天再尝试！");
    }
  }
}
