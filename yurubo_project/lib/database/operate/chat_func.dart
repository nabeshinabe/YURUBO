import 'package:supabase/supabase.dart';
import 'package:yurubo/login_num.dart' as login_num;
// Database API 接続用
final supabase = SupabaseClient(
  'VAR_URL', // SupabaseのURLを指定
  'VAR_ANONKEY', // SupabaseのAPIキーを指定
);

Future<int> generateRoomNumber() async {
  // chat_roomテーブルからRoom_numberカラムに存在する値を取得
  final response = await supabase.from('Chat_room').select('Room_number');
  final roomNumbers = response.data.map<int>((e) => e['Room_number'] as int).toList();

  int Room_num = 1;
  do {
    Room_num += 1;
  } while (!roomNumbers.contains(Room_num));
  
  return Room_num;
}


// Chat_Roomテーブルに新しいチャットルームができた時
void createChatRoom({
  required List l //[ID(organizer) , place , max_num_people ,  time , comment]
})
 async {
  // 現在自時刻取得→create_time
  int Room_num = await generateRoomNumber();
  final now = DateTime.now();
  await supabase.from('Seeking').insert({
    'ID': Room_num,
    'place': l[1],
    'max_num_people' : l[2],
    'time': l[3],
    'comment': l[4], 
    'nummember': 1,
  });
  await supabase.from('Chat_room').insert({
    'Room_number': Room_num,
    'leader_ID': l[0],
    'create_time': now.toUtc().toString(),
    'status': false,
  });
  await supabase.from('Chat_ID').insert({
    'ID': l[0],
    'Room_number': Room_num,
  });
}

// 昨日ここまで実装

// ここから先修正済み

//誰かがjoinした時  //[ID(joiner) , ID(organizer)]
void join (String login_num, String leader_ID)
  async{
    final response_seeking = await supabase.from('Seeking').select().eq('id', leader_ID).single();
    final row_seeking = response_seeking[0];
    // nummemberカラムの値を1増やす
    int numMember = row_seeking['now_people'] as int;
    numMember += 1;
      // now_peopleを+1してSeekingテーブルに書き込む
    await supabase.from('Seeking').update({'now_people': numMember}).eq('ID', leader_ID);
    // Chat_roomのstatusをtrueに変更(人数が二人以上になったため)
    await supabase.from('Chat_room').update({'status': true}).eq('leader_ID', leader_ID);
    // Room番号取得
    final response_room_id = await supabase.from('Chat_room').select().eq('leader_ID', leader_ID).single();
    final row_room_id = response_room_id[0];
    // Chat_ID(メンバーリスト)に追加
    await supabase.from('Chat_ID').insert({
      'ID': login_num,
      'Room_number': row_room_id['Room_number'],
    });
}


// chat送信時　//[Room_number, sender_id, message]
void sendchat (int Room_number, login_num, String message)
  async{
    final now = DateTime.now();
    await supabase.from('Chat').insert({
      'Room_number': Room_number,
      'sender_ID': login_num,
      'message': message,
      'time': now, 
    });
  }

// chat内容呼び出し
Future<List<List<dynamic>>> getmessages(int Room_number) async {
  final response = await supabase.from('Chat').select('sender_ID, message, time').eq('Room_number', Room_number).order('time', ascending: true);
  List<List<dynamic>> messages = [];

  if (response.isNotEmpty) {
    for (var data in response) {
      var message = data;
      var nickname = await supabase.from('Profile').select('Nickname').eq('ID', message['sender_ID']).single();
      messages.add([
        message['sender_ID'],
        nickname,
        message['time'].toString(),
        message['message'],
      ]);
    }
  }

  return messages;    //[sender_ID, Nickname, time, message]
}


//Room_numberを指定してレコードを削除  Room_number => レコード削除
void deleteChatRoom(int Room_number) async {
  await supabase
      .from('Chat_Room')
      .delete()
      .eq('Room_number', Room_number);
}


