import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yurubo/function/add_friendpage.dart' as addfriendpage;
import 'package:yurubo/database/operate/friend_func.dart' as friend_func;
import 'package:yurubo/login_num.dart' as login_num;

List friend_list = [
  "まだ友達はいません"
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
          child: ElevatedButton(
            child: const Text(
              "Renew",
              style: TextStyle(fontSize: 20),
            ),
            onPressed: () async{
                List friend_list_0 = await friend_func.getRoomsFromSupabase(login_num.now_login_ID.toString(), supabase);            
                setState(() {friend_list = friend_list_0;});
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

// import 'package:flutter/material.dart';
// import 'package:supabase/supabase.dart';
// final supabase = SupabaseClient(
//   'https://yourproject.supabase.co',
//   'your-anon-key',
// );
// Future<List<Friend>> getFriends() async {
//   final response = await supabase
//       .from('friends')
//       .select()
//       .order('name', ascending: true)
//       .execute();
//   return (response.data as List<dynamic>)
//       .map((friend) => Friend.fromJson(friend))
//       .toList();
// }
// class Friend {
//   final int id;
//   final String name;
//   final String imageUrl;
//   const Friend({
//     required this.id,
//     required this.name,
//     required this.imageUrl,
//   });
//   factory Friend.fromJson(Map<String, dynamic> json) {
//     return Friend(
//       id: json['id'] as int,
//       name: json['name'] as String,
//       imageUrl: json['imageUrl'] as String,
//     );
//   }
// }
// void main() {
//   runApp(const MyApp());
// }
// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'ゆるぼ',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const FriendListPage(),
//     );
//   }
// }

// class FriendListPage extends StatelessWidget {
//   const FriendListPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Friend List'),
//       ),
//       body: FutureBuilder<List<Friend>>(
//         future: getFriends(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             final friends = snapshot.data!;
//             return ListView.builder(
//               itemCount: friends.length,
//               itemBuilder: (context, index) {
//                 final friend = friends[index];
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => FriendDetailPage(friend),
//                       ),
//                     );
//                   },
//                   child: ListTile(
//                     leading: const Icon(Icons.person),
//                     title: Text(friend.name),
//                   ),
//                 );
//               },
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           } else {
//             return const Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }
// }

// class FriendDetailPage extends StatelessWidget {
//   final Friend friend;

//   const FriendDetailPage(this.friend, {Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Friend Detail'),
//       ),
//       body: Center(
//         child: Text('${friend.name} Detail'),
//       ),
//     );
//   }
// }