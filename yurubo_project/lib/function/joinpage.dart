import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yurubo/function/chatpage.dart' as chatpage;
import 'package:yurubo/function/add_joinpage.dart' as addjoinpage;
import 'package:yurubo/database/operate/join_func.dart' as join_func;
import 'package:yurubo/login_num.dart' as login_num;

String join_message = " ";

List join_list = [
  // [101, "Place_A", "3/4", "17:00", "Comment_AAAAAA"],
  // [102, "Place_B", "2/4", "17:30", "Comment_BBBBBBBBBB"],
  // [103, "Place_C", "1/4", "17:30", "Comment_CCCCCCCCCCCC"],
  // [104, "Place_D", "2/4", "18:30", "Comment_DDDD"],
];

String now_join_place = '';

class JoinPage extends StatefulWidget {
  const JoinPage({super.key});
  @override
  State<StatefulWidget> createState() => JoinPageState();
}

class JoinPageState extends State<JoinPage> {
  final supabase = Supabase.instance.client;

  Card show_join_card(room_number, place, max, time, comment) {
    Card join_card = Card(
      child: Center(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 20.0),
            child: Row(
              children: [
                Column(
                  children: [
                    const SizedBox(height: 15),
                    ElevatedButton(
                      child: const Text(
                        "Select",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        setState(() {
                          now_join_place = place;

                          login_num.now_join_room_number = room_number;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    place,
                    style: const TextStyle(fontSize: 25),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      Text(
                        max,
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(width: 100),
                      Text(
                        time,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    comment,
                    style: const TextStyle(fontSize: 15),
                  ),
                ]),
              ],
            )),
      ),
    );

    return join_card;
  }

  Widget show_join_card_list() {
    List<Card> join_card_list = [];
    for (int i = 0; i < join_list.length; i++) {
      join_card_list.add(show_join_card(join_list[i][0], join_list[i][1],
          join_list[i][2], join_list[i][3], join_list[i][4]));
    }
    return Column(children: join_card_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              child: const Text(
                "Add Place",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const addjoinpage.AddJoinPage()),
                );
              }, //when press【Add Place】button
            ),
          ),
          const SizedBox(height: 10),
          const Divider(
            height: 10.0,
            indent: 10.0,
            color: Colors.blue,
          ),
          const SizedBox(height: 10),
          Row(children: [
            const SizedBox(width: 40),
            ElevatedButton(
              child: const Text(
                "Join",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                if (login_num.now_join_room_number != 0) {
                  join_func.join(login_num.now_login_ID.toString(),
                      login_num.now_join_room_number, supabase);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const chatpage.ChatPage()),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const AlertDialog(
                        content: Text(
                            "You need to choose a place first."), //何も選択されていません
                      );
                    }, //when press【Register】button
                  );
                }
              }, //when press【Join】button
            ),
            const SizedBox(width: 30),
            Text(
              now_join_place,
              style: TextStyle(fontSize: 25),
            ),
          ]),
          const SizedBox(height: 10),
          const Divider(
            height: 10.0,
            indent: 10.0,
            color: Colors.blue,
          ),
          const SizedBox(height: 10),
          Center(
            child: IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () async {
                bool is_makeroom = await join_func.is_makeroom(
                    login_num.now_login_ID, supabase);
                List join_list_0 =
                    await join_func.getRoomsFromSupabase(is_makeroom, supabase);
                setState(() {
                  join_list = join_list_0;
                  now_join_place = '';
                });
              }, //when press【Renew】button
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              show_join_card_list(),
            ],
          )),
        ],
      ),
    );
  }
}