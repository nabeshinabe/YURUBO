import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yurubo/login_num.dart' as login_num;
import 'package:yurubo/database/operate/add_join_func.dart' as add_join_func;
import 'package:yurubo/function/joinpage.dart' as joinpage;

String add_join_message = "";

final add_join_place_controller = TextEditingController();
var add_join_max;
final add_join_time_controller = TextEditingController();
final add_join_comment_controller = TextEditingController();
String add_place_fromUI() {
  return add_join_place_controller.text;
}

String add_max_fromUI() {
  return add_join_max.toString();
}

String add_time_fromUI() {
  return add_join_time_controller.text;
}

String add_comment_fromUI() {
  return add_join_comment_controller.text;
}

class AddJoinPage extends StatefulWidget {
  const AddJoinPage({super.key});
  @override
  State<StatefulWidget> createState() => AddJoinPageState();
}

class AddJoinPageState extends State<AddJoinPage> {
  final supabase = Supabase.instance.client;
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
        title: Text("Add Place"),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 20.0),
            const Text("Enter the place."),
            const SizedBox(height: 5.0),
            TextField(
              controller: add_join_place_controller,
              decoration: const InputDecoration(
                filled: true,
                labelText: "Place",
              ),
            ),
            const SizedBox(height: 30.0),
            const Text("Select the max number of people."),
            const SizedBox(height: 5.0),
            DropdownButton(
                icon: Icon(Icons.arrow_right),
                iconSize: 20,
                iconEnabledColor: Colors.green.withOpacity(0.7),
                hint: const Text('Max People'),
                items: const [
                  DropdownMenuItem(child: Text('        1'), value: 1),
                  DropdownMenuItem(child: Text('        2'), value: 2),
                  DropdownMenuItem(child: Text('        3'), value: 3),
                  DropdownMenuItem(child: Text('        4'), value: 4),
                  DropdownMenuItem(child: Text('        5'), value: 5),
                  DropdownMenuItem(child: Text('        6'), value: 6),
                  DropdownMenuItem(child: Text('        7'), value: 7),
                  DropdownMenuItem(child: Text('        8'), value: 8),
                ],
                value: add_join_max,
                onChanged: (value) => setState(() => add_join_max = value)),
            const SizedBox(height: 30.0),
            const Text("Enter the time."),
            const SizedBox(height: 5.0),
            TextField(
              controller: add_join_time_controller,
              decoration: const InputDecoration(
                filled: true,
                labelText: "Time",
              ),
            ),
            const SizedBox(height: 30.0),
            const Text("Enter the comment."),
            const SizedBox(height: 5.0),
            TextField(
              controller: add_join_comment_controller,
              decoration: const InputDecoration(
                filled: true,
                labelText: "Comment",
              ),
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
              child: const Text(
                "Add",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () async{
                String Add_place_register_message = await add_join_func.add_join(add_place_fromUI(), add_max_fromUI(), add_time_fromUI(), add_comment_fromUI(), supabase);
                // ignore: use_build_context_synchronously
                if (!context.mounted) return;
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(Add_place_register_message),
                    );
                  }, //when press【Register】button
                );
                // Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}