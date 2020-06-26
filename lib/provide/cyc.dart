import 'package:flutter/material.dart';

class CYCProvide with ChangeNotifier {
  List dataList = [];
  
  //搜索按钮
  setVal(List data) {
    dataList = data;
    notifyListeners();
  }
}