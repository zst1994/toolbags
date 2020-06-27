import 'package:flutter/material.dart';

class HLHSProvide with ChangeNotifier {
  List dataList = [];
  List checkDataList = ["印尼卢比:IDR","印尼卢比:IDR"];
  String changeMoney = "";
  //搜索按钮
  setVal(List data) {
    dataList = data;
    notifyListeners();
  }

  setCheckVal(List data) {
    checkDataList = data;
    notifyListeners();
  }

  setMoney(String money){
    changeMoney = money;
    notifyListeners();
  }
}