import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ゆるぼ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FriendListPage(),
    );
  }
}

class FriendListPage extends StatelessWidget {
  const FriendListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Friend List'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FriendDetailPage(index),
                ),
              );
            },
            child: ListTile(
              leading: const Icon(Icons.person),
              title: Text('Friend ${index + 1}'),
            ),
          );
        },
      ),
    );
  }
}

class FriendDetailPage extends StatelessWidget {
  final int friendIndex;

  const FriendDetailPage(this.friendIndex, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Friend Detail'),
      ),
      body: Center(
        child: Text('Friend ${friendIndex + 1} Detail'),
      ),
    );
  }
}
