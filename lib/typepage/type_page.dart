import 'package:flutter/material.dart';
import '../pages/yqsscx.dart';
import '../pages//tsscyq.dart';
import '../pages/news.dart';
import '../pages/hlhs.dart';
import '../pages/xhdq.dart';
import '../pages/zgjm.dart';
import '../pages/sfzcx.dart';
import '../pages/hmgsd.dart';
import '../pages/ipcx.dart';
import '../pages/njjzw.dart';
import '../pages/history.dart';
import '../pages/jryj.dart';
import '../pages/jdjg.dart';
import '../pages/cyc.dart';
import '../pages/bdc.dart';

class ButtonDemoPage extends StatelessWidget {
  Map arguments;
  ButtonDemoPage({this.arguments});
  
  Widget _typeChange() {
    switch (arguments["id"]) {
      case "0":
        return YQSSCX(arguments:this.arguments);
        break;
      case "1":
        return TSSC(arguments:this.arguments);
        break;
      case "2":
        return News(arguments:this.arguments);
        break;
      case "3":
        return HLHS(arguments:this.arguments);
        break;
      case "4":
        return XHDQ(arguments:this.arguments);
        break;
      case "5":
        return ZGJM(arguments:this.arguments);
        break;
      case "6":
        return SFZCX(arguments:this.arguments);
        break;
      case "7":
        return HMGSD(arguments:this.arguments);
        break;
      case "8":
        return IPCX(arguments:this.arguments);
        break;
      case "9":
        return NJJZW(arguments:this.arguments);
        break;
      case "10":
        return HISTORY(arguments:this.arguments);
        break;
      case "11":
        return JRYJ(arguments:this.arguments);
        break;
      case "12":
        return JDJG(arguments:this.arguments);
        break;
      case "13":
        return CYC(arguments:this.arguments);
        break;
      case "14":
        return BDC(arguments:this.arguments);
        break;
      default:
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return _typeChange();
  }
}





