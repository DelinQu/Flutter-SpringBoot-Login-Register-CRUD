import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Signup/components/body.dart';

class SignUpScreen extends StatefulWidget {
  @override
  SignUpScreenState createState() {
    return new SignUpScreenState();
  }
}

class SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //浮动按键添加联系人(系统)
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.keyboard_backspace_rounded),
          onPressed: (){
            //页面路由
            Navigator.of(context).pop(true);
          }
      ),
      body: Body(),
    );
  }
}
