import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yurubo/function/add_friendpage.dart' as addfriendpage;
import 'package:yurubo/database/operate/friend_func.dart' as friend_func;
import 'package:yurubo/login_num.dart' as login_num;

List friend_list = [
  "No friends"
  // "Friend_A",
  // "Friend_B",
  // "Friend_C",
  // "Friend_D",
  // "Friend_E",
  // "Friend_F",
  // "Friend_G",
];

class FriendPage extends StatefulWidget {
  const FriendPage({super.key});
  @override
  State<StatefulWidget> createState() => FriendPageState();
}

class FriendPageState extends State<FriendPage> {
  final supabase = Supabase.instance.client;

  Card show_friend_card(friendname) {
    Card friend_card = Card(
      child: Row(
        children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 18.0, 20.0, 18.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      friendname,
                      style: const TextStyle(fontSize: 30),
                    ),
                  ])),
          const SizedBox(width: 12),
        ],
      ),
    );
    return friend_card;
  }

  Widget show_friend_card_list() {
    List<Card> friend_card_list = [];
    for (int i = 0; i < friend_list.length; i++) {
      friend_card_list.add(show_friend_card(friend_list[i]));
    }
    return Column(children: friend_card_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(height: 20),
        Center(
          child: ElevatedButton(
            child: const Text(
              "Add Friend",
              style: TextStyle(fontSize: 20),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const addfriendpage.AddFriendPage()),
              );
            }, //when press【Add Friend】button
          ),
        ),
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
              List friend_list_0 = await friend_func.getRoomsFromSupabase(
                  login_num.now_login_ID.toString(), supabase);
              setState(() {
                friend_list = friend_list_0;
              });
            }, //when press【Renew】button
          ),
        ),
        Expanded(
            child: ListView(
          children: [
            show_friend_card_list(),
          ],
        )),
      ],
    ));
  }
}
