import 'package:flutter/material.dart';
import 'package:yurubo/function/joinpage.dart' as joinpage;
import 'package:yurubo/function/friendpage.dart' as friendpage;
import 'package:yurubo/function/mypage.dart' as mypage;
import 'package:yurubo/login_num.dart' as login_num;

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  var pages = [const joinpage.JoinPage(), const friendpage.FriendPage()];
  var currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.settings,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const mypage.MyPage()),
              );
            },
          ),
        ],
        title: const Text("YURUBO"),
      ),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.blue,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Join",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Friends",
          ),
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}