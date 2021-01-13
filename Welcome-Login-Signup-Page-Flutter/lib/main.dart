import 'package:flutter/material.dart';
import 'package:flutter_auth/utils/colorUtil.dart';
import 'package:oktoast/oktoast.dart';

import 'Screens/Welcome/welcome_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
        child:
        MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Account',
          theme: ThemeData(
            primaryColor: kPrimaryColor,
            scaffoldBackgroundColor: Colors.white,
          ),
          home: WelcomeScreen(),
        )
    );
  }
}
