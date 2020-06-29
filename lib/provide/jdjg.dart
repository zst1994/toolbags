import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:toolbag/config/common.dart';

class JDJGProvide with ChangeNotifier {
  List dataList = [];
  List newIdList = [];
  int checkIndex = 0;
  String auLastDate = "";
  String goldPrice = "";

  //搜索按钮
  setVal(List data, List idList) {
    dataList = data;
    newIdList = idList;
    notifyListeners();
  }

  setIndex(int index) {
    checkIndex = index;
    notifyListeners();
  }

  setGoldPrice(String auLast, String price) {
    auLastDate = auLast;
    goldPrice = price;
    notifyListeners();
  }
}
