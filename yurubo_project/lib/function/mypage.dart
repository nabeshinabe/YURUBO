import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});
  @override
  State<StatefulWidget> createState() => MyPageState();
}

class MyPageState extends State<MyPage> {
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
            const SizedBox(height: 10),
            ElevatedButton(
              child: const Text(
                "Change Password",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {},
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              child: const Text(
                "other function??",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {},
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              child: const Text(
                "other function??",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {},
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              child: const Text(
                "Logout",
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        ));
  }
}
