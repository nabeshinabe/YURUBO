//要らないパッケージ含む
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:data/data.dart';
// import 'dart:math';

//NicknameとPasswordの照合をし，合致すればアクセストークンとリフレッシュトークンを再発行し格納
//IDも持ってきて保持しておく
Future<List> Login(String login_username_fromUI, String login_password_fromUI, SupabaseClient supabase) async {
  final response = await supabase.from('Profile').select().eq('Nickname',login_username_fromUI).eq('Password', login_password_fromUI); // Check User

  String Message = "";

  int now_login_ID = 0;

  if (response.isEmpty){
    Message = '入力されたユーザーが存在しないか、パスワードが間違っています'; //errormeage1
  }else{
    // final ID = userData['ID'] as String;//DBからIDを取得・保持
    // final response_token = await supabase.auth.signIn(login_username_fromUI,login_password_fromUI,options:AuthOptions(accessTokenExpiresIn:3600,refreshTokenExpiresIn:604800));//期限を指定（秒数）)
    // final session = response_token.data;
    // final loginResponse.accessToken = session!.accessToken;
    // final loginResponse.refreshToken = session.refreshToken;
    // userData['access_token'] = loginResponse.accessToken;
    // userData['refresh_token'] = loginResponse.refreshToken;
    final response_data = response[0];
    now_login_ID = int.parse(response_data['ID']);
    // await supabase.from('Profile').update(userData);
    Message = "Login Successfully!";
  }
  return [Message, now_login_ID];
}