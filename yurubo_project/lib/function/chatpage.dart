import 'package:flutter/material.dart';
import 'package:yurubo/function/joinpage.dart';
import 'package:yurubo/login_num.dart' as login_num;
import 'package:yurubo/database/operate/chat_func.dart' as chat_func;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yurubo/function/joinpage.dart' as joinpage;

List chat_list = [
  // [102, "Friend_B", "17:04", "BBBBBB"],
  // [101, "Friend_A", "17:12", "AAAAAAAAAAA"],
  // [103, "Friend_C", "17:13", "CCCCCCCCCC"],
  // [101, "Friend_A", "17:16", "AAAAAAA"],
  // [103, "Friend_C", "17:17", "CCCCCCC"],
  // [104, "Friend_D", "17:25", "DDDDDDDDDDDDD"],
  // [102, "Friend_B", "17:26", "BBBBBB"],
  // [104, "Friend_D", "17:26", "DDDDDDDD"],
];

final chat_send_controller = TextEditingController();

String chat_send_fromUI() {
  return chat_send_controller.text;
}

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  final supabase = Supabase.instance.client;

  Card show_chat_card(name, time, message) {
    Card chat_card = Card(
      child: Center(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: const TextStyle(fontSize: 25),
                    ),
                    SizedBox(width: 14),
                    Text(
                      time,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    SizedBox(width: 20),
                    Text(
                      message,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                )
              ],
            )),
      ),
    );

    return chat_card;
  }

  Card show_chat_card_I(name, time, message) {
    Card chat_card = Card(
      child: Center(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: SizedBox(width: 1)),
                    Text(
                      time,
                      style: const TextStyle(fontSize: 15),
                    ),
                    SizedBox(width: 14),
                    Text(
                      name,
                      style: const TextStyle(fontSize: 25),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(child: SizedBox(width: 1)),
                    Text(
                      message,
                      style: const TextStyle(fontSize: 20),
                    ),
                    SizedBox(width: 20),
                  ],
                )
              ],
            )),
      ),
    );

    return chat_card;
  }

  Widget show_chat_card_list() {
    List<Card> chat_card_list = [];
    String time_toUI;
    for (int i = 0; i < chat_list.length; i++) {
      time_toUI = chat_list[i][2];
      time_toUI = time_toUI.substring(5, 16);
      if (chat_list[i][0] == login_num.now_login_ID.toString()) {
        chat_card_list
            .add(show_chat_card_I(chat_list[i][1], time_toUI, chat_list[i][3]));
      } else {
        chat_card_list
            .add(show_chat_card(chat_list[i][1], time_toUI, chat_list[i][3]));
      }
    }
    return Column(children: chat_card_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_sharp),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Chat Room"),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              chat_func.deleteChatRoom(
                  login_num.now_join_room_number, supabase);
              setState(() {
                login_num.now_join_room_number = 0;
                joinpage.now_join_place = '';
              });
            },
            child: const Text(
              "Dismiss",
              style: TextStyle(fontSize: 15, color: Colors.red),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Row(children: [
            const SizedBox(width: 40),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () async {
                List chat_list_0 = await chat_func.getmessages(
                    login_num.now_join_room_number, supabase);
                setState(() {
                  chat_list = chat_list_0;
                });
              }, //when press【Reload】button
            ),
            const SizedBox(width: 30),
            Text(
              now_join_place,
              style: TextStyle(fontSize: 25),
            ),
          ]),
          const Divider(
            height: 10.0,
            indent: 10.0,
            color: Colors.blue,
          ),
          Expanded(
              child: ListView(
            children: [
              show_chat_card_list(),
            ],
          )),
          const SizedBox(height: 16.0),
          Row(
            children: [
              const SizedBox(height: 100.0),
              Expanded(
                child: TextField(
                  controller: chat_send_controller,
                  decoration: const InputDecoration(
                    filled: true,
                    labelText: "Message",
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              ElevatedButton(
                child: const Text('Send'),
                onPressed: () async {
                  await chat_func.sendchat(login_num.now_join_room_number,
                      login_num.now_login_ID, chat_send_fromUI(), supabase);

                  // 送信と同時にリストの更新
                  List chat_list_0 = await chat_func.getmessages(
                      login_num.now_join_room_number, supabase);
                  setState(() {
                    chat_list = chat_list_0;
                    chat_send_controller.text = ""; // 送信と同時に書いた文字も消す
                  });
                }, //when press【Send】button
              ),
              const SizedBox(width: 10.0),
            ],
          ),
        ],
      ),
    );
  }
}