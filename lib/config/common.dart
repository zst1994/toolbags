import 'dart:io';
import 'dart:ui';
import 'package:date_format/date_format.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provide/provide.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toolbag/provide/tssc.dart';

final FontWeight fwBold = Platform.isIOS ? FontWeight.bold : FontWeight.w500;

//flutter跳转flutter页面
gotoFlutterPage(String pageUrl, Map<dynamic, dynamic> urlParams) {
  FlutterBoost.singleton.open(pageUrl, urlParams: urlParams);
}

//封装字体样式
myTextStyle(int size, int mycolor, bool fw) {
  return TextStyle(
      fontSize: size.sp,
      color: Color(mycolor),
      fontWeight: fw ? fwBold : FontWeight.normal,
      fontFamily: fw ? "PingFang-SC-Bold" : "PingFang-SC-Medium");
}

mixin InitWidgetConfig on Diagnosticable {
  void initConfig(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: true);
  }
}

//加载动画
getAnaimation() {
  return Center(
    child: Padding(
      padding: EdgeInsets.all(20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(
            backgroundColor: Colors.blue,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 1,
          ),
          SizedBox(
            width: ScreenUtil().setWidth(20.0),
          ),
          Text("加载中......"),
        ],
      ),
    ),
  );
}

void shortToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Color(0xff333333),
      textColor: Colors.white,
      fontSize: 14.0);
}

void longToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Color(0xff333333),
      textColor: Colors.white,
      fontSize: 14.0);
}

Widget searchTitle(BuildContext context,
    TextEditingController editingController, String text, Function callBack) {
  return Container(
      padding:
          EdgeInsets.only(left: 40.w, right: 40.w, top: 30.w, bottom: 30.w),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 70.h,
              ),
              child: TextField(
                  autofocus: false,
                  enableInteractiveSelection: false,
                  controller: editingController,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    suffixIcon: InkWell(
                      onTap: () {
                        editingController.text = "";
                      },
                      child: Icon(
                        Icons.close,
                        color: Color(0xff999999),
                      ),
                    ),
                    contentPadding: EdgeInsets.only(left: 40.w),
                    hintText: text,
                    hintStyle: myTextStyle(26, 0xff999999, false),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(60.w),
                        borderSide: BorderSide.none),
                    filled: true,
                    fillColor: Color(0xfffafafa),
                  ),
                  onEditingComplete: () {
                    Provide.value<TSSCProvide>(context).initDataList();
                    callBack();
                    FocusScope.of(context).requestFocus(FocusNode());
                  }),
            ),
          ),
          InkWell(
            onTap: () {
              Provide.value<TSSCProvide>(context).initDataList();
              callBack();
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(20.w, 10.h, 10.w, 10.h),
              child: Row(
                children: <Widget>[
                  Image.asset("images/search.png", width: 38.w),
                  Text(
                    '搜索',
                    style: myTextStyle(32, 0xff09abf7, false),
                  )
                ],
              ),
            ),
          )
        ],
      ));
}

//日期选择器
double kPickerHeight = 216.0;
double kItemHeight = 40.0;
Color kBtnColor = Color(0xFF787878); //50
Color kTitleColor = Color(0xFF323232); //120
double kTextFontSize = 28.0.sp;

typedef StringClickCallback = void Function(int selectIndex, Object selectStr);
typedef ArrayClickCallback = void Function(
    List<int> selecteds, List<dynamic> strData);
typedef DateClickCallback = void Function(
    dynamic selectDateStr, dynamic selectDate);

enum DateType {
  YMD, // y, m, d
  YM, // y ,m
  YMD_HM, // y, m, d, hh, mm
  YMD_AP_HM, // y, m, d, ap, hh, mm
}

class JhPickerTool {
  /** 单列*/
  static void showStringPicker<T>(
    BuildContext context, {
    @required List<T> data,
    String title,
    int normalIndex,
    PickerDataAdapter adapter,
    @required StringClickCallback clickCallBack,
  }) {
    openModalPicker(context,
        adapter: adapter ?? PickerDataAdapter(pickerdata: data, isArray: false),
        clickCallBack: (Picker picker, List<int> selecteds) {
      clickCallBack(selecteds[0], data[selecteds[0]]);
    }, selecteds: [normalIndex ?? 0], title: title);
  }

  /** 多列 */
  static void showArrayPicker<T>(
    BuildContext context, {
    @required List<T> data,
    String title,
    List<int> normalIndex,
    PickerDataAdapter adapter,
    @required ArrayClickCallback clickCallBack,
  }) {
    openModalPicker(context,
        adapter: adapter ?? PickerDataAdapter(pickerdata: data, isArray: true),
        clickCallBack: (Picker picker, List<int> selecteds) {
      clickCallBack(selecteds, picker.getSelectedValues());
    }, selecteds: normalIndex, title: title);
  }

  static void openModalPicker(
    BuildContext context, {
    @required PickerAdapter adapter,
    String title,
    List<int> selecteds,
    @required PickerConfirmCallback clickCallBack,
  }) {
    new Picker(
            adapter: adapter,
            title: new Text(title ?? "请选择",
                style: TextStyle(
                    color: kTitleColor, fontSize: 32.sp, fontWeight: fwBold)),
            selecteds: selecteds,
            cancelText: '取消',
            confirmText: '确定',
            cancelTextStyle:
                TextStyle(color: kBtnColor, fontSize: kTextFontSize),
            confirmTextStyle:
                TextStyle(color: kBtnColor, fontSize: kTextFontSize),
            textAlign: TextAlign.center,
            itemExtent: kItemHeight,
            height: kPickerHeight,
            selectedTextStyle: myTextStyle(34, 0xff333333, false),
            onConfirm: clickCallBack)
        .showModal(context);
  }

  /** 日期选择器*/
  static void showDatePicker(
    BuildContext context, {
    DateType dateType,
    String title,
    DateTime maxValue,
    DateTime minValue,
    DateTime value,
    DateTimePickerAdapter adapter,
    @required DateClickCallback clickCallback,
  }) {
    int timeType;
    if (dateType == DateType.YM) {
      timeType = PickerDateTimeType.kYM;
    } else if (dateType == DateType.YMD_HM) {
      timeType = PickerDateTimeType.kYMDHM;
    } else if (dateType == DateType.YMD_AP_HM) {
      timeType = PickerDateTimeType.kYMD_AP_HM;
    } else {
      timeType = PickerDateTimeType.kYMD;
    }

    openModalPicker(context,
        adapter: adapter ??
            DateTimePickerAdapter(
              type: timeType,
              isNumberMonth: true,
              yearSuffix: "年",
              monthSuffix: "月",
              daySuffix: "日",
              strAMPM: const ["上午", "下午"],
              maxValue: maxValue,
              minValue: minValue,
              value: value ?? DateTime.now(),
            ),
        title: title, clickCallBack: (Picker picker, List<int> selecteds) {
      var time = (picker.adapter as DateTimePickerAdapter).value;

      var timeStr;
      if (dateType == DateType.YM) {
        timeStr = time.year.toString() + "年" + time.month.toString() + "月";
      } else if (dateType == DateType.YMD_HM) {
        timeStr = time.year.toString() +
            "年" +
            time.month.toString() +
            "月" +
            time.day.toString() +
            "日" +
            time.hour.toString() +
            "时" +
            time.minute.toString() +
            "分";
      } else if (dateType == DateType.YMD_AP_HM) {
        var str = formatDate(time, [am]) == "AM" ? "上午" : "下午";
        timeStr = time.year.toString() +
            "年" +
            time.month.toString() +
            "月" +
            time.day.toString() +
            "日" +
            str +
            time.hour.toString() +
            "时" +
            time.minute.toString() +
            "分";
      } else {
        timeStr = time.year.toString() +
            "年" +
            time.month.toString() +
            "月" +
            time.day.toString() +
            "日";
      }
      clickCallback(timeStr, picker.adapter.text);
    });
  }
}

Future getHttp(
    BuildContext context, String url, Map formData, Function callBack) async {
  try {
    Response response;
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded").toString();
    response = await dio.post(url, data: formData);
    if (response.statusCode == 200) {
      callBack(response.data);
      return "完成加载";
    } else {
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  } catch (e) {
    shortToast("客官你吓到人家了，稍后再来咯！");
  }
}

Future<bool> getSharedPreferences(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getBool('login') == null) {
    return false;
  }
  return true;
}
