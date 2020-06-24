import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:toolbag/config/common.dart';

class HISTORY extends StatelessWidget {
  Map arguments;
  HISTORY({this.arguments});
  final TextEditingController _searchController = TextEditingController();

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
        body: ListView(
          children: <Widget>[
            searchTitle(context, _searchController, "请输入时间查询：0101(月份日期)", () {
              print('his today');
            })
          ],
        ));
  }
}
