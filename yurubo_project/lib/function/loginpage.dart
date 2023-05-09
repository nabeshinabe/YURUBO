import 'package:flutter/material.dart';
import 'package:yurubo/function/homepage.dart' as homepage;
import 'package:yurubo/function/registerpage.dart' as registerpage;

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 80.0),
            const Center(
              child: Text(
                'YURUBO',
                style: TextStyle(fontSize: 30),
              ),
            ),
            const SizedBox(height: 120.0),
            const TextField(
              decoration: InputDecoration(
                filled: true,
                labelText: "Username",
              ),
            ),
            const SizedBox(height: 12.0),
            const TextField(
              decoration: InputDecoration(
                filled: true,
                labelText: "Password",
              ),
              obscureText: true,
            ),
            const SizedBox(height: 12.0),
            ElevatedButton(
              child: const Text(
                "Login",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const homepage.HomePage()),
                );
              },
            ),
            const SizedBox(height: 60.0),
            TextButton(
              child: const Text(
                "Register",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const registerpage.RegisterPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}