import 'package:flutter/material.dart';
import "package:yurubo/database/operate/register_func.dart" as register;
import 'package:supabase_flutter/supabase_flutter.dart';

final register_username_controller = TextEditingController();
final register_password_controller = TextEditingController();
final register_password_again_controller = TextEditingController();
String register_username_fromUI() {
  return register_username_controller.text;
}

String register_password_fromUI() {
  return register_password_controller.text;
}

String register_password_again_fromUI() {
  return register_password_again_controller.text;
}


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<StatefulWidget> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final supabase = Supabase.instance.client;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_sharp,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Register"),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 20.0),
            const Text(
                "Enter your username. \nUsername can only include characters, numbers and underscores."),
            const SizedBox(height: 5.0),
            TextField(
              controller: register_username_controller,
              decoration: InputDecoration(
                filled: true,
                labelText: "Username",
              ),
            ),
            const SizedBox(height: 30.0),
            const Text(
                "Enter your password. \nPassword can only include characters and numbers."),
            const SizedBox(height: 5.0),
            TextField(
              controller: register_password_controller,
              decoration: InputDecoration(
                filled: true,
                labelText: "Password",
              ),
            ),
            const SizedBox(height: 12.0),
            const Text("Enter your password again."),
            const SizedBox(height: 5.0),
            TextField(
              controller: register_password_again_controller,
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
              onPressed: () async{
                String register_message = await register.register(register_username_fromUI(), register_password_fromUI(), register_password_again_fromUI(), supabase);
                // ignore: use_build_context_synchronously
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(register_message),
                    );
                  }, //when press【Register】button
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}