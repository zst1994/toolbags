import 'package:flutter/material.dart';
import 'package:toolbag/pages/webview/web_view_pages.dart';
import 'package:toolbag/pages/wordsList/words.dart';
import '../typepage/type_page.dart';
import '../splash_screen.dart';

//配置路由
final routes = {
  //启动动画
  '/': (context) => SplashScreen(),
  '/buttonPage': (context, {arguments}) => ButtonDemoPage(arguments: arguments),
  '/webview': (context, {arguments}) => WebViewPage(arguments: arguments),
  '/words': (context, {arguments}) => WordsPage(arguments: arguments),
};

//固定写法
var onGenerateRoute = (RouteSettings settings) {
  // 统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
