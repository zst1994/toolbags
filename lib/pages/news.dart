import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import 'package:toolbag/config/common.dart';
import 'package:toolbag/provide/news.dart';

//新闻
class News extends StatefulWidget {
  Map arguments;
  News({this.arguments});

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  ScrollController _controller = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  List newDataList;
  List newsList = [];
  List contentlist = [];
  bool showContentBool;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        _getMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Provide.value<NEWSProvide>(context).setContentBool(false);

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
              widget.arguments["title"],
              style: myTextStyle(38, 0xffffffff, false),
            )),
        body: FutureBuilder(
            future: getHttp(context, widget.arguments["url"], {
              "showapi_appid": "163797",
              "showapi_sign": "7167be83432346a79e6cdf50e16b88dd",
            }, (data) async {
              await Provide.value<NEWSProvide>(context)
                  .setVal(data["showapi_res_body"]["channelList"]);
            }),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Provide<NEWSProvide>(builder: (context, child, val) {
                  newDataList =
                      Provide.value<NEWSProvide>(context).newsDataList;
                  showContentBool =
                      Provide.value<NEWSProvide>(context).showBool;
                  contentlist = Provide.value<NEWSProvide>(context).newsList;
                  print(contentlist);
                  return RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: ListView(
                      controller: _controller,
                      children: <Widget>[
                        searchTitle(context, _searchController, "请输入新闻关键词搜索",
                            () {
                          Provide.value<NEWSProvide>(context)
                              .setContentBool(true);
                          Provide.value<NEWSProvide>(context).initNewsList();

                          getHttp(context, "https://route.showapi.com/109-35", {
                            "showapi_appid": "163797",
                            "showapi_sign": "7167be83432346a79e6cdf50e16b88dd",
                            "title": _searchController.text,
                            "page": Provide.value<NEWSProvide>(context).page
                          }, (data) async {
                            await Provide.value<NEWSProvide>(context)
                                .setNewsList(data["showapi_res_body"]
                                    ["pagebean"]["contentlist"]);
                          });
                        }),
                        showContentBool || _searchController.text.length > 0
                            ? _newsListContent(context)
                            : _newTitle()
                      ],
                    ),
                  );
                });
              } else {
                return getAnaimation();
              }
            }));
  }

  Widget _newTitle() {
    return Container(
      padding: EdgeInsets.only(left: 40.w, right: 40.w),
      child: Wrap(
          direction: Axis.horizontal,
          spacing: 16, //主轴方向间距
          runSpacing: 8, //纵轴方向间距
          alignment: WrapAlignment.start, //主轴方式对齐方式
          runAlignment: WrapAlignment.center, //纵轴方式对齐方式
          children: newDataList.map((item) {
            return InkWell(
              onTap: () {
                _searchController.text = item["name"];
              },
              child: Container(
                padding: EdgeInsets.only(
                    left: 16.w, right: 16.w, top: 6.h, bottom: 6.h),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.w)),
                child: Text(
                  item["name"],
                  style: myTextStyle(24, 0xff666666, false),
                ),
              ),
            );
          }).toList()),
    );
  }

  Widget _newsListContent(BuildContext context) {
    return Column(
      children: contentlist.map((item) {
        return InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/webview', arguments: {
              "link": item["link"],
              "title": item["title"],
            });
          },
          child: Container(
            margin: EdgeInsets.only(left: 40.w, right: 40.w, bottom: 30.w),
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.w), color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  item["title"],
                  style: myTextStyle(32, 0xff000000, true),
                ),
                item["imageurls"].length > 0
                    ? SizedBox(
                        height: 10.h,
                      )
                    : Container(),
                item["imageurls"].length > 0
                    ? _imgList(item["imageurls"])
                    : Container(),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      item["source"],
                      style: myTextStyle(28, 0xff666666, false),
                    ),
                    Text(
                      item["pubDate"],
                      style: myTextStyle(28, 0xff666666, false),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _imgList(List imgList) {
    return Wrap(
        direction: Axis.horizontal,
        spacing: 16, //主轴方向间距
        runSpacing: 8, //纵轴方向间距
        alignment: WrapAlignment.start, //主轴方式对齐方式
        runAlignment: WrapAlignment.center, //纵轴方式对齐方式
        children: imgList.map((item) {
          return Image.network(
            item["url"],
            width: 160.w,
          );
        }).toList());
  }

  Future _onRefresh() async {
    await Provide.value<NEWSProvide>(context).initPage();
    await Provide.value<NEWSProvide>(context).initNewsList();
    await getHttp(context, "https://route.showapi.com/109-35", {
      "showapi_appid": "163797",
      "showapi_sign": "7167be83432346a79e6cdf50e16b88dd",
      "title": _searchController.text,
      "page": Provide.value<NEWSProvide>(context).page
    }, (data) async {
      await Provide.value<NEWSProvide>(context)
          .setNewsList(data["showapi_res_body"]["pagebean"]["contentlist"]);
    });
  }

  Future _getMore() async {
    await Provide.value<NEWSProvide>(context).addPage();
    await getHttp(context, "https://route.showapi.com/109-35", {
      "showapi_appid": "163797",
      "showapi_sign": "7167be83432346a79e6cdf50e16b88dd",
      "title": _searchController.text,
      "page": Provide.value<NEWSProvide>(context).page
    }, (data) async {
      await Provide.value<NEWSProvide>(context)
          .setNewsList(data["showapi_res_body"]["pagebean"]["contentlist"]);
    });
  }
}
//新闻
