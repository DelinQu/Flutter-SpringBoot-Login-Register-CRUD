import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Home/components/SearchBar.dart';
import 'package:flutter_auth/utils/URL.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oktoast/oktoast.dart';
import 'MyProfile.dart';

class Manager extends StatefulWidget {
  @override
  ManagerState createState() {
    return new ManagerState();
  }
}

class ManagerState extends State<Manager> {
  var personList=[];
  Color mainColor = const Color(0xff3C3261);
  String searchUsername;


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
          personList = response.data;
        });
    }
    else{
      showToast("服务器或网络错误!");
    }
  }

  void _Search(dynamic) async {
    if(searchUsername==null || searchUsername=="") return;
    print("Searching");
    print("Text:"+searchUsername);
    //获取数据
    String getUrl = baseURL+'/profile/findByUsernameLike?username='+searchUsername;
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
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new SearchBar(
        leading: new Icon(
          Icons.camera,
          color: Colors.greenAccent,
        ),
        onChanged: (value){
            setState(() {
              searchUsername=value;
            });
        },
        onSearch: _Search,
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
                      child: getManagerCell(i, personList),
                      padding: const EdgeInsets.all(0.0),
                      onPressed: () {
                        Navigator.push(context,
                            new MaterialPageRoute(builder: (context) {
                              return MyProfile(email: personList[i]['email'],);
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

  Widget getManagerCell(i,persons) {
    return new Column(
      children: <Widget>[
        new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.all(0.0),
              child: new Container(
                margin: const EdgeInsets.all(16.0),
                child: new Container(
                  width: 70.0,
                  height: 70.0,
                ),
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.circular(10.0),
                  color: Colors.grey,
                  image: new DecorationImage(
                      image: new NetworkImage(persons[i]["path"]==null?defaultAsURL:persons[i]["path"]),
                      fit: BoxFit.cover),
                  boxShadow: [
                    new BoxShadow(
                        color: mainColor,
                        blurRadius: 5.0,
                        offset: new Offset(2.0, 5.0))
                  ],
                ),
              ),
            ),
            new Container(
              width: 120.0,
              margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
              child: new Column(
                children: [
                  new Text(
                    persons[i]['username'],
                    maxLines: 1,
                    style: new TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'Arvo',
                        fontWeight: FontWeight.bold,
                        color: mainColor),
                  ),
                  new Padding(padding: const EdgeInsets.all(2.0)),
                  new Text(
                    persons[i]['email'],
                    maxLines: 3,
                    style: new TextStyle(
                        color: const Color(0xff8785A4), fontFamily: 'Arvo'),
                  )
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
            new Expanded(
              child: _getEditIcon(i),
            ),
            new Expanded(
              child: _getDeleteIcon(persons[i]['email'].toString()),
            ),
          ],
        ),
      ],
    );
  }

  Widget _getEditIcon(i) {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.greenAccent,
        radius: 12.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) {
              return MyProfile(email: personList[i]['email'],);
            }));
      },
    );
  }
  Widget _getDeleteIcon(email) {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.red,
        radius: 12.0,
        child: new Icon(
          Icons.phonelink_erase_rounded,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        showAlertDialog(email);
      },
    );
  }

  showAlertDialog(email) {
    //设置按钮
    Widget cancelButton = FlatButton(
      child: Text("取消"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("确认"),
      onPressed:  () {
        print("delete");
        delete(email);
        Navigator.pop(context);
        initState();
      },
    );
    //设置对话框
    AlertDialog alert = AlertDialog(
      title: Text("提示消息"),
      content: Text("请确认是否删除?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    //显示对话框
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  //获取数据
  Future<List> delete(email) async {
    String deleteUrl = baseURL+'/profile/delete?email='+email;
    Dio dio = new Dio();
    var response = await dio.get(deleteUrl);
    print('Respone ${response.statusCode}');
    print(response.data);
    //前台似乎很方便? 因为后台已经处理了大部分逻辑! shit, 我是个全栈, 都由我来做!
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: response.data,
          gravity: ToastGravity.CENTER,
          textColor: Colors.grey);
      initState();
    }
    else{
      showToast("服务器或网络错误!");
    }
  }
}
