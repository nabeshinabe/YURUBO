import 'package:flutter/material.dart';

class AddFriendPage extends StatelessWidget {
  const AddFriendPage({super.key});
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
        title: const Text("Add Friend"),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 20.0),
            const Text("Enter your friend's name."),
            const SizedBox(height: 5.0),
            const TextField(
              decoration: InputDecoration(
                filled: true,
                labelText: "Friend's name",
              ),
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
              child: const Text(
                "Add",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}