import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:toolbag/config/common.dart';

class HLHS extends StatelessWidget {
  Map arguments;
  HLHS({this.arguments});
  TextEditingController editingController = TextEditingController();

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
        body: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      bottom:
                          BorderSide(width: 1.w, color: Color(0xff999999)))),
              child: Row(
                children: <Widget>[
                  InkWell(
                      onTap: () {
                        var bb = [];
                        bb.add(["11", "22"]);
                        bb.add(["33", "44"]);
                        JhPickerTool.showArrayPicker(context,
                            data: bb, title: "货币汇率转换", normalIndex: [0, 1],
                            clickCallBack: (var index, var strData) {
                          print(index);
                          print(strData);
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 40.w, top: 40.w, bottom: 40.w),
                        child: Text('data'),
                      )),
                  Expanded(
                    flex: 1,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: 80.h,
                      ),
                      child: TextField(
                          autofocus: false,
                          enableInteractiveSelection: false,
                          controller: editingController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          textAlign: TextAlign.end,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(right: 40.w),
                            hintText: '请输入转换金额',
                            hintStyle: myTextStyle(26, 0xff999999, false),
                            filled: true,
                            fillColor: Color(0xffffffff),
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                          ),
                          onEditingComplete: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                          }),
                    ),
                  )
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  InkWell(
                      onTap: () {
                        var bb = [];
                        bb.add(["11", "22"]);
                        bb.add(["33", "44"]);
                        JhPickerTool.showArrayPicker(context,
                            data: bb, title: "货币汇率转换", normalIndex: [0, 1],
                            clickCallBack: (var index, var strData) {
                          print(index);
                          print(strData);
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 40.w, top: 40.w, bottom: 40.w),
                        child: Text('data'),
                      )),
                  Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(right: 40.w),
                        alignment: Alignment.centerRight,
                        child: Text(
                          'data',
                          style: myTextStyle(26, 0xff999999, false),
                        ),
                      ))
                ],
              ),
            ),
          ],
        ));
  }
}
