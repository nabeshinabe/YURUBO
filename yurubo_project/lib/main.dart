import 'package:flutter/material.dart';
import 'package:yurubo/function/loginpage.dart' as loginpage;

// ここから実験
void main() {
  runApp(const MaterialApp(
    title: 'YURUBO',
    // 最初はログインページから
    home: loginpage.LoginPage(),
  ));
}


