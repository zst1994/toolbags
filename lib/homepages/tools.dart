import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toolbag/config/common.dart';

import 'package:toolbag/data/dataList.dart';

class ToolsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({Key key, this.title}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

List<Widget> _buildType(BuildContext context) {
  var templatealist = dateType.map((value) {
    return FlatButton(
      padding: EdgeInsets.all(0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Image.asset(
              value["src"],
              width: 80.w,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            value["text"],
            style: myTextStyle(26, 0xff333333, false),
          )
        ],
      ),
      onPressed: () {
        // gotoFlutterPage("buttonPage",
        //     {"id": value["id"], "title": value["text"], "url": value["url"]});
        Navigator.pushNamed(context, '/buttonPage', arguments: {
          "id": value["id"],
          "title": value["text"],
          "url": value["url"]
        });
      },
    );
  });
  return templatealist.toList();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: <Widget>[
        // 轮播图
        Container(
          child: AspectRatio(
            aspectRatio: 16 / 7,
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Image.asset(
                  imgList[index]["imgUrl"],
                  fit: BoxFit.cover,
                );
              },
              itemCount: imgList.length,
              autoplay: true,
              duration: 1000,
              pagination: SwiperPagination(
                  // 分页指示器
                  alignment:
                      Alignment.bottomCenter, // 位置 Alignment.bottomCenter 底部中间
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 5), // 距离调整
                  builder: DotSwiperPaginationBuilder(
                      // 指示器构建
                      space: ScreenUtil().setWidth(5), // 点之间的间隔
                      size: 12.w, // 没选中时的大小
                      activeSize: 14.w, // 选中时的大小
                      color: Colors.black54, // 没选中时的颜色
                      activeColor: Colors.white)),
            ),
          ),
        ),
        // 工具功能选择
        Container(
          margin:
              EdgeInsets.only(left: 40.w, right: 40.w, bottom: 30.w, top: 30.w),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20.w)),
          child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              childAspectRatio: 1.0,
              crossAxisCount: 3,
              children: _buildType(context)),
        ),
      ],
    ));
  }
}
