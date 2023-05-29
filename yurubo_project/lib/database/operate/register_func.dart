// 要らないパッケージ含む
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:math';

// ログイン，ログアウト，サインアップ，パスワード変更，現ログインユーザーの特定

// Profile=[Nickname, Password, ID, now_login_ID, access_token, refresh_token]

// 関数説明
// LoginとLogin_auto関数は，まずautoの方をアプリ起動時点で使って，if文がtrueならログイン成功で次の画面へ，何も起きなければNicknameとPasswordを入力してもらってLogin関数を使う
Future<String> register(
    String register_username_fromUI,
    String register_password_fromUI,
    String register_password_again_fromUI,
    SupabaseClient supabase) async {
  final records = await supabase
      .from('Profile')
      .select('Nickname')
      .eq('Nickname', register_username_fromUI);

  String Message = "";
  if (records != null && records.isNotEmpty) {
    Message = 'The username has been used.'; //このNicknameは使われています
  } else if (register_password_fromUI.length < 8) {
    Message =
        'Password must be at least 8 characters'; //Passwordは8文字以上で入力してください
  } else if (register_password_fromUI != register_password_again_fromUI) {
    Message = 'The two entered passwords do not match.'; //Passwordが一致しません
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
    while (true) {
      int ID_select = generateRandomNumber();

      final records2 =
          await supabase.from('Profile').select('ID').eq('ID', ID_select);

      if (records2.isEmpty && ID_select.toString().length == 8) {
        ID = ID_select;
        break;
      }
    }
    //アクセストークン，リフレッシュトークンの発行,格納
    // final response_token = await supabase.auth.signUp(register_username_fromUI,register_password_fromUI,options:AuthOptions(accessTokenExpiresIn:3600,refreshTokenExpiresIn:604800));//期限を指定（秒数）
    // final session = response_token.data;
    // final accessToken = session!.accessToken;
    // final refreshToken = session.refreshToken;

    // final user = {'Nickname':register_username_fromUI, 'Password':register_password_fromUI,'ID':ID,'now_login_ID':ID, 'access_token':accessToken, 'refresh_token':refreshToken};
    final user = {
      'Nickname': register_username_fromUI,
      'Password': register_password_fromUI,
      'ID': ID
    };
    await supabase.from('Profile').insert([user]);

    Message = "Register Successfully!";

  } //→signupとlogin成功なので次の画面へ, それ以外ならエラーメッセージを出力してその画面のまま留まる
  return Message;
}