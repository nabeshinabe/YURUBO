import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});
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
        title: const Text("Register"),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 20.0),
            const Text(
                "Enter your username. \nUsername can only include characters, numbers and underscores."),
            const SizedBox(height: 5.0),
            const TextField(
              decoration: InputDecoration(
                filled: true,
                labelText: "Username",
              ),
            ),
            const SizedBox(height: 30.0),
            const Text(
                "Enter your password. \nPassword can only include characters and numbers."),
            const SizedBox(height: 5.0),
            const TextField(
              decoration: InputDecoration(
                filled: true,
                labelText: "Password",
              ),
            ),
            const SizedBox(height: 12.0),
            const Text("Enter your password again."),
            const SizedBox(height: 5.0),
            const TextField(
              decoration: InputDecoration(
                filled: true,
                labelText: "Password Again",
              ),
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
              child: const Text(
                "Register",
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