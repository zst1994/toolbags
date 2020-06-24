import 'package:flutter/material.dart';

class JRYJProvide with ChangeNotifier {
  Map dataList = {};
  
  //搜索按钮
  setVal(Map data) {
    dataList = data;
    notifyListeners();
  }
}