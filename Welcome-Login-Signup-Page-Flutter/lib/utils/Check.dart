/*
* 用于校验的工具类
* */

// 邮箱校验
import 'package:flutter/cupertino.dart';

void initState() {
  var passwordVisible = false; //设置初始状态
}

final String regexEmail = "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$";
bool isEmail(String input) {
  if (input == null || input.isEmpty) return false;
  return new RegExp(regexEmail).hasMatch(input);
}


//username校验
final String regexUsername = r'^[a-zA-Z]\w+$';
final String regexUsernamejudge = r'(?=.*?[A-Z])';
bool isUsername(String input) {
  if (input == null || input.isEmpty || input=='' || input.length < 5 || input.length > 11) return false;
  return (new RegExp(regexUsername).hasMatch(input)&&new RegExp(regexUsernamejudge).hasMatch(input));
}

//password校验
final String regexPassword = r'^\w+$';
bool isPassword(String input) {
  if (input == null || input.isEmpty || input=='' || input.length < 6 || input.length > 13 ) return false;
  return (new RegExp(regexPassword).hasMatch(input));
}

//Mobile校验
final String regexMobilenum = r'^1[3456789][0-9]+$';
bool isMobile(String input) {
  if ( ! ( input.length == 0 ) ){
    if(! ( input.length == 11 )) return false;
    return (new RegExp(regexMobilenum).hasMatch(input));
  }
  else return true;
}

//Age校验 0-130岁
final String regexAge = r'^[0-9]?[0-9]$';
bool isAge(String input) {
  if ( ! ( input.length == 0 ) ){
    if(input.length >2 ) return false;
    return (new RegExp(regexAge).hasMatch(input));
  }
  else return true;
}