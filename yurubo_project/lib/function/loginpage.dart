import 'package:flutter/material.dart';
import 'package:yurubo/function/homepage.dart' as homepage;
import 'package:yurubo/function/registerpage.dart' as registerpage;
import 'package:yurubo/database/operate/login_func.dart' as login_func;
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:yurubo/login_num.dart' as login_num;

final login_username_controller = TextEditingController();
final login_password_controller = TextEditingController();
String login_username_fromUI() {
  return login_username_controller.text;
}

String login_password_fromUI() {
  return login_password_controller.text;
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final supabase = Supabase.instance.client;
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
            TextField(
              controller: login_username_controller,
              decoration: InputDecoration(
                filled: true,
                labelText: "Username",
              ),
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: login_password_controller,
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
              onPressed: () async{
                List register_message = await login_func.Login(login_username_fromUI(), login_password_fromUI(), supabase);
                
                // IDが0じゃなければページ遷移
                if(register_message[1] != 0){
                  login_num.now_login_ID = register_message[1];
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const homepage.HomePage()),
                  );
                }else{
                  // ignore: use_build_context_synchronously
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text(register_message[0]),
                      );
                    }, //when press【Register】button
                  );
                }
              }, //when press【Login】button
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
                  MaterialPageRoute(
                      builder: (context) => const registerpage.RegisterPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}