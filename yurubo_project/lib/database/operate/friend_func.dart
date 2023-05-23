import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yurubo/login_num.dart' as login_num;

// 友達リスト
Future<List<dynamic>> getRoomsFromSupabase(String loginid, SupabaseClient supabase) async {
  final response = await supabase.from('Friend').select('friend_ID').eq('ID', loginid);
  List displaylist = [];

  if (response.isNotEmpty){
    for (var data in response){
      var name = await supabase.from("Profile").select("Nickname").eq('ID', data["friend_ID"]);
      displaylist.add(
        name[0]["Nickname"]
      );
    }
  }
  return displaylist;
}