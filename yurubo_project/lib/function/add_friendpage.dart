import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yurubo/login_num.dart' as login_num;
import 'package:yurubo/database/operate/add_friend_func.dart' as add_friend_func;


String add_friend_message = "";

final add_friend_friendname_controller = TextEditingController();
String add_friendname_fromUI() {
  return add_friend_friendname_controller.text;
}
class AddFriendPage extends StatefulWidget {
  const AddFriendPage({super.key});
  @override
  State<StatefulWidget> createState() => AddFriendPageState();
}

class AddFriendPageState extends State<AddFriendPage> {
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
        title: const Text("Add Friend"),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 20.0),
            const Text("Enter your friend's ID."),
            const SizedBox(height: 5.0),
            TextField(
              controller: add_friend_friendname_controller,
              decoration: InputDecoration(
                filled: true,
                labelText: "Friend's ID",
              ),
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
              child: const Text(
                "Add",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () async{
                String Add_friend_message = await add_friend_func.add_friend(add_friendname_fromUI(), supabase);
                // ignore: use_build_context_synchronously
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(Add_friend_message),
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