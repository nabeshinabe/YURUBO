import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yurubo/login_num.dart' as login_num;

Future<List<dynamic>> getRoomsFromSupabase(SupabaseClient supabase) async {
  final response = await supabase.from('Seeking').select('Room_number, place, time, comment, max_people, now_people');
  List seeking_list_toUI=[];
  if (response.isNotEmpty) {
    
      final friends = await supabase.from('Friend').select('friend_ID').eq('ID', login_num.now_login_ID.toString());
      List friends_ID_List = [];
      for(int index=0; index < friends.length; index+=1){
        friends_ID_List.add(friends[index]["friend_ID"]);
      }
      var room_num = await supabase.from('Chat_room').select('Room_number').in_('leader_ID', friends_ID_List);
      List room_num_List = [];
      for(int index=0; index < room_num.length; index+=1){
        room_num_List.add(room_num[index]["Room_number"]);
      }

      List seeking_list=[];
      for (int Room_number in room_num_List){
        seeking_list.add(await supabase.from('Seeking').select('Room_number, place, time, comment, max_people, now_people').eq("Room_number", Room_number));
      }

      //print(seeking_list[0]);

      // var room_lists = response.where((response) => response['Room_number'] == room_num['Room_number']).toList();
      // room_lists = response.where((response) => response['Room_number'] == room_lists['Room_number']).toList();

      // var nick = await supabase.from("Profile").select("Nickname").eq('ID', friends_ID_List);
      // seeking_list=
      // [
      // [{Room_number: 640033, place: KU, time: 18:00, comment: go!, max_people: 3, now_people: 1}]
      // [{Room_number: 640033, place: KU, time: 18:00, comment: go!, max_people: 3, now_people: 1}]
      // [{Room_number: 640033, place: KU, time: 18:00, comment: go!, max_people: 3, now_people: 1}]
      // ]
    
      for (int index=0; index < seeking_list.length; index+=1)
      {
        List list=[];
        list.add(seeking_list[index][0]["Room_number"]);
        list.add(seeking_list[index][0]["place"]);
        list.add(seeking_list[index][0]["max_people"]);
        list.add(seeking_list[index][0]["time"]);
        list.add(seeking_list[index][0]["comment"]);
        seeking_list_toUI.add(list);
      }
  }

  return seeking_list_toUI;
}

//誰かがjoinした時  //[ID(joiner) , Room_num]
void join (String login_num, int Room_number, SupabaseClient supabase)
  async{
    final response_seeking = await supabase.from('Seeking').select().eq('Room_number', Room_number);
    final row_seeking = response_seeking[0];
    print(row_seeking);
    // nummemberカラムの値を1増やす
    int numMember = int.parse(row_seeking['now_people']);
    numMember += 1;
      // now_peopleを+1してSeekingテーブルに書き込む
    await supabase.from('Seeking').update({'now_people': numMember.toString()}).eq('Room_number', Room_number);
    // Chat_roomのstatusをtrueに変更(人数が二人以上になったため)
    await supabase.from('Chat_room').update({'status': true}).eq('Room_number', Room_number);
    await supabase.from('Chat_ID').insert({
      'ID': login_num,
      'Room_number': Room_number,
    });
}