import 'package:flutter/material.dart';
import 'package:toolbag/config/common.dart';

import 'package:toolbag/homepages/more.dart';
import 'package:toolbag/homepages/tools.dart';

class HomePages extends StatefulWidget {
  @override
  _HomePagesState createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> with InitWidgetConfig {
  int _curentIndex = 0;

  List<Widget> pages = [ToolsPage(), MorePages()];

  @override
  Widget build(BuildContext context) {
    initConfig(context);
    return Scaffold(
      backgroundColor: Color(0xffF3F3F3),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).accentColor,
        centerTitle: true,
        title: Text(
          '哆啦A梦工具袋',
          style: myTextStyle(38, 0xffffffff, false),
        ),
      ),
      //底部导航
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _curentIndex,
          onTap: (int index) {
            setState(() {
              this._curentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                activeIcon: Image.asset(
                  'images/GJ_02.png',
                  width: 24.0,
                  height: 24.0,
                ),
                icon: Image.asset(
                  'images/GJ_01.png',
                  width: 24.0,
                  height: 24.0,
                ),
                title: Text(
                  '工具',
                  style: TextStyle(color: Colors.black87, fontSize: 12.0),
                )),
            BottomNavigationBarItem(
                activeIcon: Image.asset(
                  'images/more_02.png',
                  width: 24.0,
                  height: 24.0,
                ),
                icon: Image.asset(
                  'images/more_01.png',
                  width: 24.0,
                  height: 24.0,
                ),
                title: Text(
                  '更多',
                  style: TextStyle(color: Colors.black87, fontSize: 12.0),
                ))
          ]),
      body: Center(
        child: this.pages[_curentIndex],
      ),
    );
  }
}
