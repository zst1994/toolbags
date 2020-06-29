import 'package:flutter/material.dart';
import 'homepages/home_pages.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    _controller = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 3000));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) {
          return HomePages();
        }), (route) => route == null);
        // gotoFlutterPage("f2f://homePages", {});
      }
    });

    //播放动画
    _controller.forward();
    super.initState();
  }

  //销毁播放器
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Image.asset(
        'images/china_03.jpg',
        // 'images/ZZLS.jpg',
        //图片缩放
        scale: 1.0,
        fit: BoxFit.cover,
        alignment: Alignment.lerp(Alignment.centerLeft, Alignment.center, 0.7),
      ),
    );
  }
}
