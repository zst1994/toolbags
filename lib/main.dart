import 'dart:io';

import 'package:provide/provide.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:toolbag/provide/hmgsd.dart';
import 'package:toolbag/provide/ipcx.dart';
import 'package:toolbag/provide/jryj.dart';
import 'package:toolbag/provide/sfzcx.dart';
import 'package:toolbag/provide/tssc.dart';
import 'package:toolbag/provide/yqsscx.dart';
import 'package:toolbag/splash_screen.dart';
import 'routes/Routes.dart';

void main() {
  var yqDataList = YQSSCXProvide();
  var tsDataList = TSSCProvide();
  var sfzDataList = SFZCXProvide();
  var hmgsdDataList = HMGSDProvide();
  var ipcxDataList = IPCXProvide();
  var jryjDataList = JRYJProvide();
  
  var providers = Providers();

  providers
    ..provide(Provider<YQSSCXProvide>.value(yqDataList))
    ..provide(Provider<TSSCProvide>.value(tsDataList))
    ..provide(Provider<SFZCXProvide>.value(sfzDataList))
    ..provide(Provider<HMGSDProvide>.value(hmgsdDataList))
    ..provide(Provider<IPCXProvide>.value(ipcxDataList))
    ..provide(Provider<JRYJProvide>.value(jryjDataList));

  runApp(ProviderNode(child: MyApp(), providers: providers));

  if (Platform.isAndroid) {
    //设置Android头部的导航栏透明
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, //全局设置透明
        statusBarIconBrightness: Brightness.light
        //light:黑色图标 dark：白色图标
        //在此处设置statusBarIconBrightness为全局设置
        );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FlutterBoost.singleton.registerPageBuilders({
      //flutter跳flutter
      // 'f2f://homePages': (pageName, params, _) => HomePages(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DLAM ToolBag',
      theme: ThemeData(
        primaryColor: Color(0xffffffff),
        primaryColorDark: Color(0xffffffff),
        primaryColorLight: Color(0xffB3E5FC),
        accentColor: Color(0xff8BC34A),
        dividerColor: Color(0xffBDBDBD),
        dialogBackgroundColor: Color.fromARGB(80, 255, 255, 255),
        primarySwatch: Colors.lightBlue,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      onGenerateRoute: onGenerateRoute,
    );
  }
}
