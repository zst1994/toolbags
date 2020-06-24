import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:toolbag/config/common.dart';

class NJJZW extends StatefulWidget {
  final Map arguments;
  NJJZW({Key key, this.arguments}) : super(key: key);

  @override
  _NJJZWState createState() => _NJJZWState(arguments: this.arguments);
}

class _NJJZWState extends State<NJJZW> {
  Map arguments;
  _NJJZWState({this.arguments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff3f3f3),
      appBar: AppBar(
          elevation: 0.0,
          leading: IconButton(
              icon: Image.asset(
                'images/fanhui_01@2x.png',
                width: 18.w,
              ),
              onPressed: () => Navigator.pop(context)),
          centerTitle: true,
          backgroundColor: Color(0xff09abf7),
          title: Text(
            arguments["title"],
            style: myTextStyle(38, 0xffffffff, false),
          )),
    );
  }
}
