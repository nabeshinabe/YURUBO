import 'package:supabase/supabase.dart';

// Database API 接続用
final supabase = SupabaseClient(
  'SUPABASE_URL', // SupabaseのURLを指定
  'SUPABASE_KEY', // SupabaseのAPIキーを指定
);

// // Chat_Roomテーブルに新しいチャットルームができた時
// Future<void> createChatRoom({
//   required String roomNumber,
//   required String leaderId,
// }) async {
//   // 現在自時刻取得→create_time
//   final now = DateTime.now();

//   final response = await supabase.from('Chat_Room').insert({
//     'Room_number': roomNumber,
//     'Leader_id': leaderId,
//     'create_time': now.toUtc().toString(),
//     'status': true, // bool型の値を指定
//   }).execute();

//   if (response.error != null) {
//     throw Exception(response.error!.message);
//   }
// }

// //Chatを送信した時
// Future<void> sendMessage({
//   required String roomId,
//   required String senderId,
//   required String message,
// }) async {
//   final now = DateTime.now();

//   final response = await supabase.from('Chat').insert({
//     'room_number': roomId,
//     'sender_id': senderId,
//     'message': message,
//     'time': now.toUtc().toString(),
//   }).execute();

//   if (response.error != null) {
//     throw Exception(response.error!.message);
//   }
// }

// //Room_numberを指定してレコードを削除
// Future<void> deleteChatRoom(String roomId) async {
//   final response = await supabase
//       .from('Chat_Room')
//       .delete()
//       .eq('Room_number', roomId)
//       .execute();

//   if (response.error != null) {
//     throw Exception(response.error!.message);
//   }
// }

// //chat_roomのメッセージ抜き出し
// Future<List<Map<String, dynamic>>> getChatMessagesByRoomId(String roomId) async {
//   final response = await supabase
//       .from('Chat')
//       .select('sender_id, message, time')
//       .eq('room_number', roomId)
//       .order('time', ascending: true)
//       .execute();

//   if (response.error != null) {
//     throw Exception(response.error!.message);
//   }

//   return response.data as List<Map<String, dynamic>>;
// }

// //chatroomの作成
// Future<void> createChatRoomWithUniqueRoomNumber({
//   // required String title,
//   // required String description,
//   required String leaderId,
// }) async {
//   final now = DateTime.now();

//   // Leader_idから新しいRoom_numberを生成する
//   final roomId = '${leaderId.substring(0, 4)}-${now.microsecondsSinceEpoch}';

//   final response = await supabase.from('Chat_Room').insert({
//     'Room_number': roomId,
//     'Leader_id': leaderId,
//     'create_time': now.toUtc().toString(),
//     'status': 'active',
//   }).execute();

//   if (response.error != null) {
//     throw Exception(response.error!.message);
//   }
// }

// //chatに参加した人をChat_idに追加
// Future<void> addChatId({
//   required int id,
//   required String room_number,
// }) async {
//   final response = await supabase.from('Chat_ID').insert({
//     'id': id,
//     'Room_number': room_number,
//   }).execute();

//   if (response.error != null) {
//     throw Exception(response.error!.message);
//   }
// }




