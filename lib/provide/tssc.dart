import 'package:flutter/material.dart';

class TSSCProvide with ChangeNotifier {
  List<Map> dataList = [];
  String poetId;
  String biography;
  int page = 1;

  //搜索按钮
  setVal(String newPoetId, String newBiography) {
    poetId = newPoetId;
    biography = newBiography;
    notifyListeners();
  }

  setList(List<Map> data) {
    dataList = data;
    notifyListeners();
  }

  initPage() {
    page = 1;
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
}
