import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:math';
import 'package:yurubo/login_num.dart' as login_num;

// //友達追加
// //frinendのテーブル
Future<String> add_friend(String new_friend_ID, SupabaseClient supabase) async {
  final record = await supabase.from('Profile').select('ID').eq('ID', new_friend_ID);

  String Message = "";
  if (record.isEmpty){
    Message = '存在しない人です。';//errormessage1
  }else {   
    final record_friend = await supabase.from('Friend').select('friend_ID').eq('friend_ID', new_friend_ID).eq('ID', login_num.now_login_ID);

    // 入力IDが登録済みではないかをチェック
    if (record_friend.isNotEmpty){
        Message = 'その友達は既に登録済みです。';//errormessage1
    }else {
      // 入力IDが自分ではないかをチェック
      if(login_num.now_login_ID == int.parse(new_friend_ID)){
        Message = 'それはあなたのIDです。';//errormessage1
      }else{
        // final user = {'Nickname':register_username_fromUI, 'Password':register_password_fromUI,'ID':ID,'now_login_ID':ID, 'access_token':accessToken, 'refresh_token':refreshToken};
        final user = {'ID':login_num.now_login_ID, 'friend_ID':record[0]["ID"]};
        final user_reverse = {'ID':record[0]["ID"], 'friend_ID':login_num.now_login_ID};
        await supabase.from('Friend').insert([user]);
        await supabase.from('Friend').insert([user_reverse]);
  
        Message = record[0]["ID"] + " 友達追加に成功しました。";
      }
    }

  } //→signupとlogin成功なので次の画面へ, それ以外ならエラーメッセージを出力してその画面のまま留まる
  return Message;
}