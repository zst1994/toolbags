import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:toolbag/config/common.dart';

class BDC extends StatelessWidget {
  Map arguments;
  BDC({this.arguments});
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _getHttp(context, arguments["url"], {
      "showapi_appid": "175397",
      "showapi_sign": "8b1d37c0b5a0423ea258a1b2450ebf8d",
    });
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
            searchTitle(context, _searchController, "请选择类型", () {
              print('his today');
            })
          ],
        ));
  }

  Future _getHttp(BuildContext context, String url, Map formData) async {
    // await Provide.value<CYCProvide>(context).setVal([]);
    try {
      Response response;
      Dio dio = new Dio();
      dio.options.contentType =
          ContentType.parse("application/x-www-form-urlencoded").toString();
      response = await dio.post(url, data: formData);
      if (response.statusCode == 200) {
        print(response.data["showapi_res_body"]["typeList"]);
        // await Provide.value<CYCProvide>(context).setVal(_cycList);
        return "完成加载";
      } else {
        throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
      }
    } catch (e) {
      shortToast("接口异常,请明天再尝试！");
    }
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/services.dart';
// import 'dart:convert';

// typedef List<Widget> CreateWidgetList();

// class CityPicker {
//   static Widget show() {
//     return new _CityPicker();
//   }
// }

// class _CityPicker extends StatefulWidget {
//   @override
//   State createState() {
//     return new _CityPickerState();
//   }
// }

// class _CityPickerState extends State<_CityPicker> {
//   List data = new List();
//   List province = new List();
//   List city = new List();
//   List area = new List();
//   FixedExtentScrollController provinceController =
//       new FixedExtentScrollController();
//   FixedExtentScrollController cityController =
//       new FixedExtentScrollController();
//   FixedExtentScrollController areaController =
//       new FixedExtentScrollController();
//   int provinceIndex = 0;
//   int cityIndex = 0;
//   int areaIndex = 0;

//   void _loadData() {
//     rootBundle.loadString('assets/data/province.json').then((v) {
//       List data = json.decode(v);
//       setState(() {
//         this.data = data;
//         this.province = data;
//         this.city = data[provinceIndex]['children'];
//         this.area = data[provinceIndex]['children'][cityIndex]['children'];
//       });
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     _loadData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: new AppBar(
//         title: new Text('省市县三级联动'),
//         centerTitle: true,
//       ),
//       body: new Container(
//         width: double.infinity,
//         child: new Column(
//           children: <Widget>[
//             new Row(
//               children: <Widget>[
//                 FlatButton(onPressed: () {}, child: new Text('取消')),
//                 FlatButton(
//                     onPressed: () {
//                       print(data[provinceIndex]);
//                       print(data[provinceIndex]['children'][cityIndex]);
//                       print(data[provinceIndex]['children'][cityIndex]
//                           ['children'][areaIndex]);
//                     },
//                     child: new Text('选择')),
//               ],
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             ),
//             new Expanded(
//               child: new Row(
//                 mainAxisSize: MainAxisSize.max,
//                 children: <Widget>[
//                   new Expanded(
//                     flex: 1,
//                     child: new MyPicker(
//                       controller: provinceController,
//                       key: Key('province'),
//                       createWidgetList: () {
//                         return province.map((v) {
//                           return new Text(v['label']);
//                         }).toList();
//                       },
//                       changed: (int index) {
//                         setState(() {
//                           cityController.jumpToItem(0);
//                           areaController.jumpToItem(0);
//                           provinceIndex = index;
//                           cityIndex = 0;
//                           areaIndex = 0;
//                           city = data[provinceIndex]['children'];
//                           area = data[provinceIndex]['children'][cityIndex]
//                               ['children'];
//                         });
//                       },
//                     ),
//                   ),
//                   new Expanded(
//                     flex: 1,
//                     child: new MyPicker(
//                       controller: cityController,
//                       key: Key('city'),
//                       createWidgetList: () {
//                         return city.map((v) {
//                           return new Text(v['label']);
//                         }).toList();
//                       },
//                       changed: (index) {
//                         setState(() {
//                           areaController.jumpToItem(0);
//                           cityIndex = index;
//                           areaIndex = 0;
//                           area = data[provinceIndex]['children'][cityIndex]
//                               ['children'];
//                         });
//                       },
//                     ),
//                   ),
//                   new Expanded(
//                     flex: 1,
//                     child: new MyPicker(
//                       controller: areaController,
//                       key: Key('area'),
//                       createWidgetList: () {
//                         return area.map((v) {
//                           return new Text(v['label']);
//                         }).toList();
//                       },
//                       changed: (index) {
//                         setState(() {
//                           areaIndex = index;
//                         });
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class MyPicker extends StatefulWidget {
//   final CreateWidgetList createWidgetList;
//   final ValueChanged<int> changed;
//   final Key key;
//   final FixedExtentScrollController controller;

//   MyPicker({this.createWidgetList, this.changed, this.key, this.controller});

//   @override
//   State createState() {
//     return new _MyPickerState();
//   }
// }

// class _MyPickerState extends State<MyPicker> {
//   @override
//   Widget build(BuildContext context) {
//     return new Container(
//       child: new CupertinoPicker(
//         key: widget.key,
//         scrollController: widget.controller,
//         itemExtent: 40.0,
//         onSelectedItemChanged: (index) {
//           if (widget.changed != null) {
//             widget.changed(index);
//           }
//         },
//         children: widget.createWidgetList().length > 0
//             ? widget.createWidgetList()
//             : [new Text('请选择')],
//       ),
//     );
//   }
// }