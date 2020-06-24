import 'package:flutter/material.dart';

class YQSSCXProvide with ChangeNotifier {
  List dataList;
  
  //搜索按钮
  setVal(List data) {
    dataList = data;
    notifyListeners();
  }
}