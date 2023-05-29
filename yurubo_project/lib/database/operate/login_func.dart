import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yurubo/login_num.dart' as login_num;

//NicknameとPasswordの照合をし，合致すればアクセストークンとリフレッシュトークンを再発行し格納
//IDも持ってきて保持しておく
Future<List> Login(String login_username_fromUI, String login_password_fromUI,
    SupabaseClient supabase) async {
  final response = await supabase
      .from('Profile')
      .select()
      .eq('Nickname', login_username_fromUI)
      .eq('Password', login_password_fromUI); // Check User

  String Message =
      "Wrong username or password."; //入力されたユーザーが存在しないか、パスワードが間違っています

  int now_login_ID = 0;

  if (response.isEmpty) {
    Message = 'Wrong username or password.'; //入力されたユーザーが存在しないか、パスワードが間違っています
  } else {
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

    // // 参加しているルームがあるかをチェック
    final join_room_num_list = await supabase
        .from('Chat_ID')
        .select('Room_number')
        .eq('ID', now_login_ID);

    int join_room_num = 0;
    if (join_room_num_list.isNotEmpty) {
      join_room_num = join_room_num_list[0]["Room_number"];
      login_num.now_join_room_number = join_room_num;
    }

    Message = "Login successfully!";
  }
  return [Message, now_login_ID];
}