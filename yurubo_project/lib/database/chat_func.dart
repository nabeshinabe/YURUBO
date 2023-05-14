import 'package:supabase/supabase.dart';
import 'package:supabase/supabase.dart';

// Database API 接続用
final supabase = SupabaseClient(
  'URL', // SupabaseのURLを指定
  'APIキー', // SupabaseのAPIキーを指定
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
Future<void> createChatRoom({
  required List l //[ID(organizer) , place , time , comment]
})
 async {
  // 現在自時刻取得→create_time
  int Room_num = await generateRoomNumber();
  final now = DateTime.now();
  await supabase.from('Seeking').insert({
    'ID': Room_num,
    'place': l[1],
    'time': l[2],
    'comment': l[3], 
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

//誰かがjoinした時
Future<void> join ({
  required List l //[ID(joiner) , ID(organizer)]
})
  async{
    final response_seeking = await supabase.from('Seeking').select().eq('id', l[1]).single();
    final row_seeking = response_seeking.data;
    // nummemberカラムの値を1増やす
    int numMember = row_seeking['nummember'] as int;
    numMember += 1;
      // 更新されたデータをデータベースに書き込む
    await supabase.from('Seeking').update({'nummember': numMember}).eq('id', l[1]);
    // Chat_roomのstatusをtrueに変更(人数が二人以上になったため)
    await supabase.from('Chat_room').update({'status': true}).eq('leader_ID', l[1]);
    final response_room_id = await supabase.from('Chat_room').select().eq('leader_ID', l[1]).single();
    final row_room_id = response_seeking.data;
    // Chat_ID(メンバーリスト)に追加
    await supabase.from('Chat_ID').insert({
      'ID': l[0],
      'Room_number': row_room_id['Room_number'],
    });
}

// chat送信時
Future<void> sendchat ({
  required List l //[Room_number , sender_id , message]
})
  async{
    final now = DateTime.now();
    await supabase.from('Chat').insert({
      'Room_number': l[0],
      'sender_id': l[1],
      'message': l[2],
      'time': now, 
    });
  }

// chat内容呼び出し
Future<List<Map<String, dynamic>>> getmessages({
  required int roomnumber
}) 
  async {
    final response = await supabase.from('Chat').select('sender_id,message,time').eq('Room_number',roomnumber).order('time', ascending: true);
    List messages = response.data;
    if (messages.isNotEmpty){
      if (messages.length == 1){
        messages = [messages];}
      }
    else {
      messages = [{}];
    }
  return messages as List<Map<String, dynamic>>;
}

//Room_numberを指定してレコードを削除  roonID => レコード削除
Future<void> deleteChatRoom(String roomId) async {
  await supabase
      .from('Chat_Room')
      .delete()
      .eq('Room_number', roomId)
      ;
}



