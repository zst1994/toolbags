import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import 'package:toolbag/config/common.dart';
import 'package:toolbag/provide/hmgsd.dart';

class HMGSD extends StatelessWidget {
  Map arguments;
  HMGSD({this.arguments});
  final TextEditingController _searchController = TextEditingController();
  Map hmgsdDataList;

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
            backgroundColor: Theme.of(context).accentColor,
            title: Text(
              arguments["title"],
              style: myTextStyle(38, 0xffffffff, false),
            )),
        body: ListView(
          children: <Widget>[
            searchTitle(context, _searchController, "请输入手机号码查询", () {
              getHttp(context, arguments["url"], {
                "showapi_appid": "164260",
                "showapi_sign": "8bee29c8c2284c61939200ec8e83db8d",
                "num": _searchController.text
              }, (data) async {
                await Provide.value<HMGSDProvide>(context)
                    .setVal(data["showapi_res_body"]);
              });
            }),
            _hmgsdMess(),
            Container(
              padding: EdgeInsets.only(left: 50.w, right: 50.w, top: 30.w),
              child: Text(
                '本接口为第三方接口，是否存在收集个人信息暂时未知，请谨慎使用!!!',
                style: myTextStyle(26, 0xfff8180b, false),
              ),
            )
          ],
        ));
  }

  Widget _hmgsdMess() {
    return Provide<HMGSDProvide>(builder: (context, child, val) {
      hmgsdDataList = Provide.value<HMGSDProvide>(context).dataList;

      return Container(
        margin: EdgeInsets.only(left: 40.w, right: 40.w),
        padding: EdgeInsets.all(40.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.w), color: Colors.white),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('省份：'),
                Text(hmgsdDataList["prov"] ?? ""),
              ],
            ),
            SizedBox(
              height: 20.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('市级：'),
                Text(hmgsdDataList["city"] ?? ""),
              ],
            ),
            SizedBox(
              height: 20.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('运营商：'),
                Text(hmgsdDataList["name"] ?? ""),
              ],
            ),
            SizedBox(
              height: 20.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('省份编码：'),
                Text(hmgsdDataList["provCode"] ?? ""),
              ],
            ),
            SizedBox(
              height: 20.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('城市编码：'),
                Text(hmgsdDataList["cityCode"] ?? ""),
              ],
            ),
            SizedBox(
              height: 20.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('座机区号：'),
                Text(hmgsdDataList["areaCode"] ?? ""),
              ],
            ),
          ],
        ),
      );
    });
  }
}
