import 'package:yurubo/login_num.dart' as login_num;
import 'dart:math';
import 'package:supabase_flutter/supabase_flutter.dart';

//今のアカウント(now_ID)を指定してレコードを削除  now_ID => レコード削除
void deleteAccount(int now_ID, SupabaseClient supabase) async {
  // Chatroomを消す場合
  await supabase
      .from('Profile')
      .delete()
      .eq('ID', now_ID);
}