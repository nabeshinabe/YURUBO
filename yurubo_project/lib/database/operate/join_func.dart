import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yurubo/login_num.dart' as login_num;

Future<List<dynamic>> getRoomsFromSupabase(String loginid, SupabaseClient supabase) async {
  final response = await supabase.from('Seeking').select('ID, place, time, comment, max_people');
  List displaylist = [];
  if (response.isNotEmpty) {
    for (var data in response){
      var friends = await supabase.from('Friend').select('friend_ID').eq('ID', data['ID']);
      friends = friends.where((friends) => friends['friend_ID'] == loginid).toList();

      var nick = await supabase.from("Profile").select("Nickname").eq('ID', data["ID"]);
      if (friends.isNotEmpty){
        displaylist.add([
          nick[0]["Nickname"],
          data["place"],
          data["max_people"],
          data["time"],
          data["comment"]
        ]);
      }
    }
  }
  return displaylist;
  }