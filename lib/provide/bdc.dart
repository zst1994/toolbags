import 'package:flutter/material.dart';

class BDCProvide with ChangeNotifier {
  List dataList = [];
  List wordsList = [];
  int index = 0;
  int subIndex = 0;
  int course = 1;

  //搜索按钮
  setVal(List data) {
    dataList = data;
    notifyListeners();
  }

  setValue(int value) {
    index = value;
    notifyListeners();
  }

  setSubIndex(int subindex) {
    subIndex = subindex;
    notifyListeners();
  }

  setWordsList(List data) {
    wordsList.addAll(data);
    notifyListeners();
  }

  addCourse() {
    course++;
    notifyListeners();
  }

  initVal() {
    index = 0;
    subIndex = 0;
    notifyListeners();
  }

  initWordsList(){
    wordsList = [];
    course = 1;
    notifyListeners();
  }

  initCourse() {
    course = 1;
    notifyListeners();
  }
}
