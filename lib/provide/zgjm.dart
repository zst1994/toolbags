import 'package:flutter/material.dart';

class ZGJMProvide with ChangeNotifier {
  List dataList = [];
  int page = 1;
  //搜索按钮
  setVal(List data) {
    dataList.addAll(data);
    notifyListeners();
  }

  addPage() {
    page++;
    notifyListeners();
  }

  initDataList() {
    dataList = [];
    notifyListeners();
  }

  initPage() {
    page = 1;
    notifyListeners();
  }
}
