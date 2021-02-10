import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_auth/Screens/Home/Community.dart';
import 'package:flutter_auth/utils/colorUtil.dart';
import 'Manager.dart';
import 'MyProfile.dart';

class home extends StatefulWidget {
  home({Key key, @required this.email}) : super(key: key);
  String email;

  @override
  homeState createState() => homeState();
}

//自定义的主页
class homeState extends State<home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // 在Flutter中的每一个类都是一个控件
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        //用DefaultTabController包围,使每一个Tabbar都能对应一个页面
        appBar: PreferredSize(
            child: AppBar(
              title: Text("flutter profile"),
              centerTitle: true, //居中
              actions: <Widget>[
                //右侧行为按钮
                IconButton(
                  color: Colors.black,
                  icon: Icon(Icons.cast),
                )
              ],
            ),
            preferredSize: Size.fromHeight(45)),


        drawer: Drawer(
          //侧面栏
            child: ListView(
              //一个列表// 抽屉可能在高度上超出屏幕，所以使用 ListView 组件包裹起来，实现纵向滚动效果
              // 干掉顶部灰色区域
              padding: EdgeInsets.all(0),
              // 所有抽屉中的子组件都定义到这里：
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountEmail: Text('qdl.cs@qq.com'),
                  accountName: Text("LinXiaoDe"),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1595780602873&di=7f0575b8a8cae012a829fb93fa5c8a04&imgtype=0&src=http%3A%2F%2Fp0.ifengimg.com%2Fpmop%2F2018%2F0809%2FD5AD6058C6F7F813F01E0AF06364286B93F53E27_size21_w600_h399.jpeg'),
                  ),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://pic2.zhimg.com/80/v2-5667cfc00148b02c8aff3f3bc966bacd_720w.jpg')) //背景图片
                  ), //美化当前控件
                ),
                ListTile(
                  title: Text('用户反馈'),
                  trailing: Icon(
                    Icons.feedback,
                    color: Colors.blue,
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text('系统设置'),
                  trailing: Icon(
                    Icons.settings,
                    color: Colors.green,
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text('发布'),
                  trailing: Icon(
                    Icons.send,
                    color: Colors.deepPurpleAccent,
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text('注销'),
                  trailing: Icon(
                    Icons.exit_to_app,
                    color: Colors.amberAccent,
                  ),
                ),
              ],
            )),
        bottomNavigationBar: Container(
          //底部导航栏
          //美化
          decoration: BoxDecoration(
            color: colorBlueText,
            borderRadius: BorderRadius.circular(3),
          ),
          height: 50, //一般tabbar的高度为50
//        borderRadius: BorderRadius.circular(50),
          child: TabBar(
            labelStyle: TextStyle(height: 0, fontSize: 10),
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.supervised_user_circle_outlined),
                text: "Community",
              ),
              Tab(
                icon: Icon(Icons.keyboard),
                text: "Manager",
              ),
              Tab(
                icon: Icon(Icons.account_box),
                text: "MyProfile",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Community(),
            Manager(),
            MyProfile(email: widget.email),
          ],
        ),
      ),
    );
  }
}

