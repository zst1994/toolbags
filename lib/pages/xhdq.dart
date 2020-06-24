import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:toolbag/config/common.dart';

class XHDQ extends StatelessWidget {
  Map arguments;
  XHDQ({this.arguments});

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
        body: ListView(
          children: <Widget>[_xhContent()],
        ));
  }

  Widget _xhContent() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20.w)),
      margin: EdgeInsets.only(left: 40.w, right: 40.w, top: 30.w),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            padding: EdgeInsets.only(top: 25.w, bottom: 25.w),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1.w, color: Color(0xffcccccc)))),
            child: Text('分享20个冷笑话，让你笑得停不下来'),
          ),
          Container(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Html(
              data:
                  "\t\t\t<p>1.一天，牛给驴出了一个难题，问“蠢”字下面两只虫子哪只是公的，哪只是母的。驴绞尽脑汁，还是答不上来。牛骂道：真是头蠢驴，男左女右嘛！</p>\n<p>2.毕业后七年，总算接了个大工程，造一根三十米烟囱，工期两个月，造价三十万，不过要垫资。总算在去年年底搞完了。今天人家去验收，被人骂得要死，还没有钱拿。！图纸看反了，人家是要挖一口井！</p>\n<p>3.一醉汉不慎从三楼掉下，引来路人围观，一警察过来：发生什么事？醉汉：不清楚，我也是刚到。</p>\n<p>4.医生问病人是怎么骨折的。病人说，我觉得鞋里有沙子，就扶着电线杆抖鞋。有个经过那里，以为我触电了，便抄起木棍给了我两棍子！</p>\n<p>5.乌龟受伤。让蜗牛去买药。过了2个小时。蜗牛还没回来。乌龟急了骂道：他再不回来老子就死了！这时门外传来了蜗牛的声音：你再说老子不去了！</p>\n<p>6.某人养一猪，烦，弃之，然猪知归路，数弃无功。一日，其驾车转了很多弯弃猪，深夜致电家人，问：“猪归否？”答曰：“已归！”其怒吼：“让它接电话，老子迷路了！</p>\n<p>7.大象不小心踩到蚂蚁窝，蚂蚁们倾巢而出，纷纷爬到大象身上。大象抖抖身子，蚂蚁们都掉了下来。此时还有一只在大象的脖子上，掉下的蚂蚁大声叫到“掐死它”。</p>\n<p>8.一日上电脑课，有一排同学的电脑死机了。于是一位同学站起来说：“老师，电脑死机了，我们这排全死了。”这时，许多同学都说：“我们也死了。”这时老师问：“还有谁没死？”只有一位同学站起来：“我还没死！”老师奇怪的说：“全班都死了，你为什么不死？”</p>\n<p>9.一猴子吃花生前都要先塞进屁股再拿出来吃。对此管理员解释道：曾有人喂它桃子，结果桃核拉不出来，猴子吓怕了，现在一定要量好再吃。</p>\n<p>10.大二时，全宿舍的女生都喜欢周华建的歌，一盘磁带被大家借来借去的。一日，上铺的女生问：我的周华建呢？下铺的女生回答：在我床上呢！两秒钟寂静无声，然后全体翻倒在床。</p>\n<p>11.上课睡觉:某生上课时睡觉，被老师发现。老师：“你为什么在上课时睡觉？”某生：“我没睡觉哇！”老师：“那你为什么闭上眼睛？”某生：“我在闭目沉思！”老师：“那你为什么直点头？”某生：“您刚才讲得很有道理！”老师：“那你为什么直流口水？”谋生：“老师秀色可餐。”</p>\n<p>12.我很高兴以为孩子们都怕我,谁知太太之后说:&#8217;家中只有你最听话,乖!快去帮我买袋盐'(最后只能说明我是个好男生)</p>\n<p>13.从前有俩人,一个叫装,一个叫消一天消不见了,装正好见有一帮人在打架,就过去扒拉,说:我找消!那帮人愣了一下说:你是不是装啊?对啊,我是!</p>\n<p>14.母亲再一次叫儿子起床:&#8217;雅克,好孩子,该起床了你听公鸡叫了好几遍了&#8221;公鸡叫与我有什么关联?我又不是母鸡&#8217;</p>\n<p>15.黑猩猩不留意踩到了长臂猿拉的大便，长臂猿温柔细心地帮其擦洗干净后它们相爱了。别人问起他们是怎样走到一齐的？黑猩猩感慨地说：猿粪！都是猿粪啊！</p>\n<p>16.老公拿着一个兰花碗，十分郑重地对老婆说：“你以后不好再摔碗了，这碗是你妈留下的，此刻只剩两只了，其他的都让你给摔了。”老婆白了老公一眼，说：“那你以后也不许气我，我也是我妈留下的，只留了我一个。”</p>\n<p>17.我有四个孩子,都十分顽皮,一天下班回家,孩子们正在家门口吵闹不休太太见我回来很高兴的说:&#8217;你最后回来了,好极了&#8217;我很高兴以为孩子们都怕我,谁知太太又之后说:&#8217;家中只有你最听话,乖!快去帮我买袋盐&#8217;</p>\n<p>18.所谓一见钟情，但是见色起意；所谓日久生情，但是权衡利弊。所谓哥们最牛，但是是牛皮哄哄。所谓姐们最浪，但是是装模作样。祝你开心放浪。</p>\n<p>19.赫鲁晓夫参观农场，记者照了一张他在猪圈和猪一齐的照片。次日见报，旁边有附言：左起第三位为赫鲁晓夫同志。</p>\n<p>20.孩子正思考有关“遗传与环境“的问题。母亲插话道：这个问题很简单嘛，大家都知道如果孩子像父亲，那就是遗传；像邻居，那就是环境。</p>\n\t\t",
            ),
          )
        ],
      ),
    );
  }
}
