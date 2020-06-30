import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toolbag/config/common.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatelessWidget {
  Map arguments;
  WebViewPage({this.arguments});

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
                onPressed: () => Navigator.pop(context, {"result": true})),
            centerTitle: true,
            backgroundColor: Theme.of(context).accentColor,
            title: Text(
              arguments["title"],
              style: myTextStyle(38, 0xffffffff, false),
            )),
        body: Builder(builder: (BuildContext context) {
          return WebView(
            initialUrl: arguments["link"],
            //JS执行模式 是否允许JS执行
            javascriptMode: JavascriptMode.unrestricted,
          );
        }));
  }
}
