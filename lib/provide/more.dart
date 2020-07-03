import 'package:flutter/material.dart';

class MoreProvide with ChangeNotifier {
  Map dataList = {
    "user": "请先登录",
    "login": false,
    "path": "images/head_boy.png",
    "headBool": false
  };

  //搜索按钮
  setVal(Map data) {
    dataList = data;
    notifyListeners();
  }
}
