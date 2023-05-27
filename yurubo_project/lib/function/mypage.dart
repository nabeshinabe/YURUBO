import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yurubo/login_num.dart' as login_num;
import 'package:yurubo/database/operate/mypage_func.dart' as mypage_func;

class MyPage extends StatefulWidget {
  const MyPage({super.key});
  @override
  State<StatefulWidget> createState() => MyPageState();
}

class MyPageState extends State<MyPage> {
  final supabase = Supabase.instance.client;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_sharp,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text("My Page"),
        ),
        
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: [
            const Text("Your ID"),
            Text(login_num.now_login_ID.toString()),
            SizedBox(height: 10),
            ElevatedButton(
              child: const Text(
                "Change Password",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {},
            ),
            SizedBox(height: 10),
            ElevatedButton(
              child: const Text(
                "other function??",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {},
            ),
            SizedBox(height: 10),
            ElevatedButton(
              child: const Text(
                "Delete This Account",
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),
              onPressed: () {
                mypage_func.deleteAccount(login_num.now_login_ID, supabase);
                Navigator.pop(context);
                Navigator.pop(context);
                setState(() {
                  login_num.now_login_ID = 0;
                  login_num.now_join_room_number = 0;
                });
              },
            ),
            SizedBox(height: 40),
            ElevatedButton(
              child: const Text(
                "Logout",
                style: TextStyle(fontSize: 20, color: Colors.yellow),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
                setState(() {
                  login_num.now_login_ID = 0;
                });
              },
            ),
          ],
        ));
  }
}