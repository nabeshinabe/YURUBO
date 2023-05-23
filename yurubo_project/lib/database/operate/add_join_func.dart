import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yurubo/login_num.dart' as login_num;

Future<int> generateRoomNumber(SupabaseClient supabase) async {
  // chat_roomテーブルからRoom_numberカラムに存在する値を取得
  final response = await supabase.from('Chat_room').select('Room_number');
  final roomNumbers = response.map<int>((e) => e['Room_number'] as int).toList();

  int Room_num = 1;
  do {
    Room_num += 1;
  } while (!roomNumbers.contains(Room_num));
  
  return Room_num;
}

// 募集開始
Future<String> add_join(String Place, String Max_people, String Time, String Comment, SupabaseClient supabase) async {
  // デバッグ用
  await supabase
    .from('Seeking')
    .delete()
    .match({ 'ID': login_num.now_login_ID});
  //

  final response = await supabase.from('Seeking').select().eq('ID', login_num.now_login_ID);

  String Message = "";

  if (response.isNotEmpty){
    Message = 'あなたは既に募集しています。'; //errormeage1
  }else{
    final add_data = {'ID':login_num.now_login_ID, 'place':Place, 'max_people':Max_people, 'now_people': 1, 'time':Time, 'comment':Comment};
    await supabase.from('Seeking').insert([add_data]);

    // チャットルームを作成
    int Room_num = await generateRoomNumber(supabase); // Room_ID
    // 現在自時刻取得→create_time
    final now = DateTime.now();

    await supabase.from('Chat_room').insert({
      'Room_number': Room_num,
      'Leader_ID': login_num.now_login_ID,
      'create_time': now.toUtc().toString(),
      'status': false,
    });
    await supabase.from('Chat_ID').insert({
      'ID': login_num.now_login_ID,
      'Room_number': Room_num,
    });

    Message = "募集を開始します！";
  }

  return Message;
}