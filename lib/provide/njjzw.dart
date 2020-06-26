import 'package:flutter/material.dart';

class NJJZWProvide with ChangeNotifier {
  List dataList = [];
  
  //搜索按钮
  setVal(List data) {
    dataList = data;
    notifyListeners();
  }
}