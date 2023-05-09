import 'package:flutter/material.dart';

class AddJoinPage extends StatelessWidget {
  const AddJoinPage({super.key});
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
        title: const Text("Add Restaurant"),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 20.0),
            const Text("Enter the restaurant's name."),
            const SizedBox(height: 5.0),
            const TextField(
              decoration: InputDecoration(
                filled: true,
                labelText: "Restaurant",
              ),
            ),
            const SizedBox(height: 30.0),
            const Text("Enter the max number of people."),
            const SizedBox(height: 5.0),
            const TextField(
              decoration: InputDecoration(
                filled: true,
                labelText: "Max People",
              ),
            ),
            const SizedBox(height: 30.0),
            const Text("Enter the time."),
            const SizedBox(height: 5.0),
            const TextField(
              decoration: InputDecoration(
                filled: true,
                labelText: "Time",
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