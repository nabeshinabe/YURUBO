import 'package:flutter/material.dart';
import 'package:yurubo/function/loginpage.dart' as loginpage;
import 'package:yurubo/database/database.dart' as database;

// ここから実験
void main() {
  // Database読み出し
  database.main();
  
  // // Database読み出した状態で実行
  // runApp(const MaterialApp(
  //   title: 'YURUBO',
  //   // 最初はログインページから
  //   home: loginpage.LoginPage(),
  // ));
}


