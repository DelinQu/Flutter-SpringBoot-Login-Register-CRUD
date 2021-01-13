import 'package:dio/dio.dart';
import 'package:flutter_auth/Screens/Home/MyProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/utils/URL.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oktoast/oktoast.dart';
import 'components/PersonCell.dart';
import 'components/ReadOnlyProfile.dart';

class Community extends StatefulWidget {
  @override
  CommunityState createState() {
    return new CommunityState();
  }
}

class CommunityState extends State<Community> {
  var personList=[];
  Color mainColor = const Color(0xff3C3261);

  void getData() async {
    //获取数据
    String getUrl = baseURL+'/profile/findAll';
    Dio dio = new Dio();

    var response = await dio.get(getUrl);

    print('Respone ${response.statusCode}');

    //前台似乎很方便? 因为后台已经处理了大部分逻辑! shit, 我是个全栈, 都由我来做!
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
              msg: "sucess",
          gravity: ToastGravity.CENTER,
          textColor: Colors.grey);

        setState(() {
          //必须要通过这个来更新数据,否则将不会刷新页面
          personList=response.data;
        });
    }
    else{
      showToast("服务器或网络错误!");
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // getData();
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        elevation: 0.3,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: new Icon(
          Icons.supervised_user_circle_outlined,
          color: Colors.greenAccent,
        ),
        title: new Text(
          'Community',
          style: new TextStyle(
              color: mainColor,
              fontFamily: 'Arvo',
              fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          new Icon(
            Icons.list,
            color: Colors.greenAccent,
          )
        ],
      ),
      body: new Padding(
        padding: const EdgeInsets.all(16.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Expanded(
              //循环结构
              child: new ListView.builder(
                  itemCount: personList == null ? 0 : personList.length,
                  itemBuilder: (context, i) {
                    return new FlatButton(
                      child: new PersonCell(i: i, persons: personList),
                      padding: const EdgeInsets.all(0.0),
                      onPressed: () {
                        print(personList[i]['path']);
                        Navigator.push(context,
                            new MaterialPageRoute(builder: (context) {
                              return ReadOnlyProfile(email: personList[i]['email']);
                            }));
                      },
                      color: Colors.white,
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
