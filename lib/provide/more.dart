import 'package:flutter/material.dart';

class MoreProvide with ChangeNotifier {
  Map dataList = {"user": "请先登录", "login": false};

  //搜索按钮
  setVal(Map data) {
    dataList = data;
    notifyListeners();
  }
}
