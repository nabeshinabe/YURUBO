import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yurubo/login_num.dart' as login_num;
import 'dart:math';

Future<int> generateRoomNumber(SupabaseClient supabase) async {
    //ランダムにIDを生成　6文字
    int generateRandomNumber() {
      const characters = '0123456789';
      final random = Random();
      String code = '';

      for (int i = 0; i < 6; i++) {
        final index = random.nextInt(characters.length);
        code += characters[index];
      }
      return int.parse(code);
    }

    int ID = 0;
    // IDの一意性をCheck
    while(true) {
      int ID_select = generateRandomNumber();

      final records2 = await supabase.from('Chat_room').select('Room_number').eq('Room_number',ID_select); 
    
      if(records2.isEmpty && ID_select.toString().length == 6){
        ID = ID_select;
        break;
      }
    }

  return ID;
}

// 募集開始
Future<String> add_join(String Place, String Max_people, String Time, String Comment, SupabaseClient supabase) async {
  final response = await supabase.from('Chat_room').select().eq('leader_ID', login_num.now_login_ID);

  String Message = "";

  if (response.isNotEmpty){
    Message = 'あなたは既に募集しています。'; //errormeage1
  }else{
    // チャットルームを作成
    int Room_num = await generateRoomNumber(supabase); // Room_ID
    // 現在自時刻取得→create_time
    final now = DateTime.now();

    await supabase.from('Chat_room').insert({
      'Room_number': Room_num,
      'leader_ID': login_num.now_login_ID,
      'create_time': now.toUtc().toString(),
      'status': false,
    });
    await supabase.from('Chat_ID').insert({
      'ID': login_num.now_login_ID,
      'Room_number': Room_num,
    });

    final add_data = {'Room_number':Room_num, 'place':Place, 'max_people':Max_people, 'now_people': 1, 'time':Time, 'comment':Comment};
    await supabase.from('Seeking').insert([add_data]);

    Message = "募集を開始します！";
  }

  return Message;
}