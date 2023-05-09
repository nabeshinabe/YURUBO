import 'package:flutter/material.dart';
import 'package:yurubo/function/add_friendpage.dart' as addfriendpage;

class FriendPage extends StatelessWidget {
  const FriendPage({super.key});

  Card show_friend_card(friend, online_state) {
    Card join_card = Card(
      child: Row(
        children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 18.0, 20.0, 18.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      friend,
                      style: const TextStyle(fontSize: 30),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        Text(
                          online_state,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    )
                  ])),
          const SizedBox(width: 12),
        ],
      ),
    );

    return join_card;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 10),
          Center(
            child: ElevatedButton(
              child: const Text(
                "Add Friend",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const addfriendpage.AddFriendPage()),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          show_friend_card("Bob", "[online]"),
          show_friend_card("Jack", "[online]"),
          show_friend_card("Frank", "[offline]"),
          show_friend_card("Dennis", "[offline]"),
          show_friend_card("Edward", "[offline]"),
          show_friend_card("Jim", "[offline]"),
          show_friend_card("Lee", "[offline]"),
          show_friend_card("Mark", "[offline]"),
        ],
      ),
    );
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