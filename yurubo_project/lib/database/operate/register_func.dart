// 要らないパッケージ含む
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:data/data.dart';
import 'dart:math';

// ログイン，ログアウト，サインアップ，パスワード変更，現ログインユーザーの特定

// Profile=[Nickname, Password, ID, now_login_ID, access_token, refresh_token]

// 関数説明
// LoginとLogin_auto関数は，まずautoの方をアプリ起動時点で使って，if文がtrueならログイン成功で次の画面へ，何も起きなければNicknameとPasswordを入力してもらってLogin関数を使う
Future<String> register(String register_username_fromUI, String register_password_fromUI, String register_password_again_fromUI, SupabaseClient supabase) async {
  final records = await supabase.from('Profile').select('Nickname').eq('Nickname',register_username_fromUI);

  String Message = "";
  if (records != null && records.isNotEmpty){
    Message = 'このNicknameは使われています';//errormessage1
  } else if (register_password_fromUI.length < 8){
    Message = 'Passwordは8文字以上で入力してください';//errormessage2
  } else if (register_password_fromUI != register_password_again_fromUI) {
    Message = 'Passwordが一致しません'; //errormassage3
  } else {
    //ランダムにIDを生成　8文字
    int generateRandomNumber() {
      const characters = '0123456789';
      final random = Random();
      String code = '';

      for (int i = 0; i < 8; i++) {
        final index = random.nextInt(characters.length);
        code += characters[index];
      }
      return int.parse(code);
    }

    int ID = 0;
    // IDの一意性をCheck
    while(true) {
      int ID_select = generateRandomNumber();

      final records2 = await supabase.from('Profile').select('ID').eq('ID',ID_select); 
    
      if(records2.isEmpty && ID_select.toString().length == 8){
        ID = ID_select;
        break;
      }
      print(ID_select);
    }
      //アクセストークン，リフレッシュトークンの発行,格納
    // final response_token = await supabase.auth.signUp(register_username_fromUI,register_password_fromUI,options:AuthOptions(accessTokenExpiresIn:3600,refreshTokenExpiresIn:604800));//期限を指定（秒数）
    // final session = response_token.data;
    // final accessToken = session!.accessToken;
    // final refreshToken = session.refreshToken;
    
    // final user = {'Nickname':register_username_fromUI, 'Password':register_password_fromUI,'ID':ID,'now_login_ID':ID, 'access_token':accessToken, 'refresh_token':refreshToken};
    final user = {'Nickname':register_username_fromUI, 'Password':register_password_fromUI, 'ID':ID};
    await supabase.from('Profile').insert([user]);

    // List<String> userID = [user['ID'].toString(), user['Nickname'].toString(), user['ID'].toString()];

    Message = "Register Successfully";
    // List<int> friendIDs = [];
    // int serializedFriendIDs = jsonEncode(to_String(friendIDs)); 
    // final user_friend = {'ID':ID, 'friendIDs':serializedFriendIDs};
    // await supabase.from('friend').insert(user_friend);//友達のリストの作成
  } //→signupとlogin成功なので次の画面へ, それ以外ならエラーメッセージを出力してその画面のまま留まる
  return Message;
}


// //IDからそのユーザーのアクセストークンとリフレッシュトークンを見つけて削除
// Future<void> Logout() async {
//  final userData  = await fetchUserByID(ID)
//  final stored_accessToen = userData['access_token'] as String;
//  final stored_refreshToen = userData['refresh_token'] as String;
 
//  await supabase.from('access_token').delete().eq('access_token',stored_accessToken).execute();
//  await supabase.from('refresh_token').delete().eq('refresh_token',stored_refreshToken).execute();
//  await supabase.from('now_login_ID').delete().eq('now_login_ID',ID).execute();
// }

// //アプリ起動時にすぐに実行する
// //アプリを立ち上げた時に，アクセストークンかリフレッシュトークンの期限が切れてなければ（存在が確認できれば），それを使って自動ログイン（ユーザーの入力なし）
// //期限が両方切れてたら，何も起こらない（ログイン画面が表示され，入力してもらってのログイン）
// Future<void> Login_auto()  async{
//  if (ID != null){
//    final userData = await fetchUserByID(ID)
//    final stored_accessToen = userData['access_token'] as String;
   
//    if (stored_accessToken == null){  //アクセストークンがない場合→リフレッシュトークンを探しに行く
//      final stored_refreshToen = userData['refresh_token'] as String;
//      if(stored_refreshToken != null){ //リフレッシュトークンがない場合は何も起こらない，ある場合アクセストークンを再発行して同じ関数を再帰
//        final response_refresh = await supabase.auth.api.refreshAccessToken(refreshToken);
//        final accessToken = response_refresh.data!.accessToken;
//        userData['acceess_token'] = acceessToken;
//        await supabase.from('Profile').update(userData).execute();
//        await Login_auto()
//      }
//     }
//    else{
//      final response_token = await supabase.auth signIn(options:AuthOptions(session:accessToken),(accessTokenExpiresIn:3600,refreshTokenExpiresIn:604800));//期限を指定（秒数）
//      if (response_token.error == null){
//        final session = response_token.data;
//        final loginResponse.accessToken = session!.accessToken;
//        final loginResponse.refreshToken = session.refreshToken;
//        userData['access_token'] = loginResponse.accessToken;
//        userData['refresh_token'] = loginResponse.refreshToken;
//        userData['now_login_ID'] = ID;
//        await supabase.from('Profile').update(userData).execute();
//       }
//     }
//   }
// }

// //アカウント確認　→これを行った後，アカウントの削除やNickname・Passwordの変更の関数へ
// Future<void> User_check(String Nickname, String Password) async{
//  final userData = await fetchUserByID(ID);
//  final stored_Nickname = userData['Nickname'] as String;
//  final stored_Password = userData['Password'] as String;
 
//  bool hasError = false;
//  if (Nickname != stored_Nickname){
//    String Error =  'Nicknameを正しく入力してください';//errormeage1
//    hasError = true;
//   }
//  if (Password != stored_Password){
//    String Error2 = 'Passwordを正しく入力してください';//errormeage2
//    hasError = true;
//   }
//  if(!hasError){
//    String message = '確認' //確認ボタン?かを押してもらう
//   }
// }  
// //アカウント削除
// Future<void> User_delete() async{
//  final stored_ID = userData['ID'] as String;
//  await supabase.from('Profile').delete().eq('ID',ID).execute();
// }

// //Nickname・Passwordの変更
// Future<void> UserData_change(String Nickname, String Password, String Password_again) async {
//  final response = await supabase.from('Profile').select('Nickname').eq('Nickname',Nickname);
//  final records = response.data;
//  bool hasError = false;
//  if (records != null && records.isNotEmpty){
//    String Error1 = 'このNicknameは使われています';//errormessage1
//    hasError = true;
//   }
//  if (Password.length < 8){
//    String Error2 = 'Passwordは8文字以上で入力してください';//errormessage2
//    hasError = true;
//   }
//  if (Password != Password_again) {
//    String Error3 = 'Passwordが一致しません'; //errormassage3
//    hasError = true;
//   } 
//   if (!hasError){
//    userData['Nickname'] = Nickname;
//    userData['Password'] = Password;
//    await supabase.from('Profile').update(userData);
//   }
// }


// //アプリ閉じた時に実行：ログインID削除
// Future<void> now_login_ID_delete() async{
//  await supabase.from('now_login_ID').delete().eq('now_login_ID',ID);
// }
