import 'package:flutter/material.dart';

class NEWSProvide with ChangeNotifier {
  List newsDataList = [];
  List newsList = [];
  bool showBool = false;
  int page = 1;
  
  initPage(){
    page = 1;
    notifyListeners();
  }

  initNewsList(){
    newsList = [];
    notifyListeners();
  }

  addPage(){
    page++;
    notifyListeners();
  }

  //搜索按钮
  setVal(List data) {
    newsDataList = data;
    notifyListeners();
  }

  setNewsList(List data) {
    newsList.addAll(data);
    notifyListeners();
  }

  setContentBool(bool contentBool){
    showBool = contentBool;
    notifyListeners();
  }
}