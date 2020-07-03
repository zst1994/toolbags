import 'package:flutter/material.dart';

class HistoryProvide with ChangeNotifier {
  List dataList = [];
  String img_url = "";
  bool show_img_bool = false;

  //搜索按钮
  setVal(List data) {
    dataList = data;
    notifyListeners();
  }

  showImg(String imgUrl, bool showImgBool) {
    img_url = imgUrl;
    show_img_bool = showImgBool;
    notifyListeners();
  }
}
