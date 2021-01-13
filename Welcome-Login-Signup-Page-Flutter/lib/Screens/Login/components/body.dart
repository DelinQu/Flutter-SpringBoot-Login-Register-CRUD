import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/components/background.dart';
import 'package:flutter_auth/Screens/Signup/signup_screen.dart';
import 'package:flutter_auth/components/already_have_an_account_acheck.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_auth/components/rounded_password_field.dart';
import 'package:flutter_auth/utils/Check.dart';
import 'package:flutter_auth/utils/URL.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_auth/Screens/Home/Home.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oktoast/oktoast.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //账户和密码
    String email="";
    String password = "";

    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {
                print("username: " + value);
                email = value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                print("password: " + value);
                password = value;
              },
              myHintText: "Password",
            ),
            RoundedButton(
              text: "LOGIN",
              //登录
              press: () {
                //校验
                print("下面是Email校验");
                if(!isEmail(email)){
                  Fluttertoast.showToast(
                      msg: "请保证邮箱正确!",
                      gravity: ToastGravity.CENTER,
                      textColor: Colors.grey);
                }
                else if(password==null||password==""){
                  Fluttertoast.showToast(
                      msg: "密码不能为空!",
                      gravity: ToastGravity.CENTER,
                      textColor: Colors.grey);
                }
                else{
                  print("try to Login");
                  login(email, password, context);
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  //登录页
  void login(String email, String password, BuildContext context) async {
    String loginURL = baseURL+'/user/login';
    Dio dio = new Dio();

    var response = await dio.post(
            loginURL,
            data: {'email': email, 'password': password}
            );
    print('Respone ${response.statusCode}');
    print(response.data);

    if (response.statusCode == 200) {//状态码200 请求是成功的
      Fluttertoast.showToast(
          msg: response.data,
          gravity: ToastGravity.CENTER,
          textColor: Colors.grey);
      if(response.data=="sucess"){
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => home(email: email)));
      }
    }
    else{
      showToast("服务器或网络错误!");
    }
  }
}
