import 'package:flutter/material.dart';

class HistoryProvide with ChangeNotifier {
  List dataList = [];
  
  //搜索按钮
  setVal(List data) {
    dataList = data;
    notifyListeners();
  }
}