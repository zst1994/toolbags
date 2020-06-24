import 'package:flutter/material.dart';

class HMGSDProvide with ChangeNotifier {
  Map dataList = {};
  
  //搜索按钮
  setVal(Map data) {
    dataList = data;
    notifyListeners();
  }
}