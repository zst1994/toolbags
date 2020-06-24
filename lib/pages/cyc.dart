import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:toolbag/config/common.dart';

class CYC extends StatefulWidget {
  final Map arguments;
  CYC({Key key, this.arguments}) : super(key: key);

  @override
  _CYCState createState() => _CYCState(arguments: this.arguments);
}

class _CYCState extends State<CYC> {
  Map arguments;
  _CYCState({this.arguments});

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
