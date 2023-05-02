dependencies:
  sqflite: ^2.0.0+3
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> openFriendsDatabase() async {
  // データベースファイルのパスを取得する
  final databasePath = await getDatabasesPath();
  final path = join(databasePath, 'friends.db');

  // データベースに接続する
  return openDatabase(
    path,
    version: 1,
    onCreate: (db, version) {
      // friendsテーブルを作成する
      db.execute('''
        CREATE TABLE friends(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          age INTEGER,
          job TEXT,
          gender TEXT,
          image TEXT
        )
      ''');
    },
  );
}
Future<List<Map<String, dynamic>>> getFriends() async {
  final db = await openFriendsDatabase();

  // friendsテーブルから全ての行を取得する
  final List<Map<String, dynamic>> maps = await db.query('friends');

  await db.close();

  return maps;
}
import 'package:flutter/material.dart';

class FriendsListPage extends StatefulWidget {
  @override
  _FriendsListPageState createState() => _FriendsListPageState();
}

class _FriendsListPageState extends State<FriendsListPage> {
  List<Map<String, dynamic>> friends = [];

  @override
  void initState() {
    super.initState();
    loadFriends();
  }

  Future<void> loadFriends() async {
    final loadedFriends = await getFriends();
    setState(() {
      friends = loadedFriends;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('友達リスト'),
      ),
      body: ListView.builder(
        itemCount: friends.length,
        itemBuilder: (context, index) {
          final friend = friends[index];
          return ListTile(
            leading: Image.network(friend['image']),
            title: Text(friend['name']),
            subtitle: Text('${friend['age']}歳 ${friend['job']}'),
          );
        },
      ),
    );
  }
}
