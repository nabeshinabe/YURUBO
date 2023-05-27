import 'package:yurubo/login_num.dart' as login_num;
import 'dart:math';
import 'package:supabase_flutter/supabase_flutter.dart';

// chat送信時　//[Room_number, sender_ID, message]
Future<void> sendchat (int Room_number, login_num, String message, SupabaseClient supabase)
  async{
    // まず各チャットにIDを設定していく
    // ランダムにIDを生成　16文字
    int generateRandomNumber() {
      const characters = '0123456789';
      final random = Random();
      String code = '';

      for (int i = 0; i < 16; i++) {
        final index = random.nextInt(characters.length);
        code += characters[index];
      }
      return int.parse(code);
    }

    int ID = 0;
    // IDの一意性をCheck
    while(true) {
      int ID_select = generateRandomNumber();

      final records2 = await supabase.from('Chat').select('Chat_numID').eq('Chat_numID',ID_select); 
    
      if(records2.isEmpty && ID_select.toString().length == 16){
        ID = ID_select;
        break;
      }
      // print(ID_select);
    }

    final now = DateTime.now().toString();
    await supabase.from('Chat').insert({
      'Room_number': Room_number,
      'sender_ID': login_num,
      'message': message,
      'time': now,
      'Chat_numID': ID,
    });
  }

// chat内容呼び出し
Future<List<List<dynamic>>> getmessages(int Room_number, SupabaseClient supabase) async {
  final response = await supabase.from('Chat').select('sender_ID, message, time').eq('Room_number', Room_number).order('time', ascending: true);
  List<List<dynamic>> messages = [];
  if (response.isNotEmpty) {
    for (var data in response) {
      var message = data;
      var nickname = await supabase.from('Profile').select('Nickname').eq('ID', message['sender_ID']);
      messages.add([
        message['sender_ID'],
        nickname[0]["Nickname"],
        message['time'],
        message['message'],
      ]);
    }
  }
  return messages;    //[sender_ID, Nickname, time, message]
}

//Room_numberを指定してレコードを削除  Room_number => レコード削除
void deleteChatRoom(int Room_number, SupabaseClient supabase) async {
  // Chatroomを消す場合
  await supabase
      .from('Chat_room')
      .delete()
      .eq('Room_number', Room_number);
}