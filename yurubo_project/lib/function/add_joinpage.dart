import 'package:flutter/material.dart';

class AddJoinPage extends StatefulWidget {
  const AddJoinPage({super.key});
  @override
  State<StatefulWidget> createState() => AddJoinPageState();
}

class AddJoinPageState extends State<AddJoinPage> {
  var value1;

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
        title: Text("Add Restaurant"),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 20.0),
            const Text("Enter the restaurant's name."),
            const SizedBox(height: 5.0),
            TextField(
              decoration: InputDecoration(
                filled: true,
                labelText: "Restaurant",
              ),
            ),
            const SizedBox(height: 30.0),
            const Text("Select the max number of people."),
            const SizedBox(height: 5.0),
            DropdownButton(
                icon: Icon(Icons.arrow_right),
                iconSize: 20,
                iconEnabledColor: Colors.green.withOpacity(0.7),
                hint: Text('Max People'),
                items: [
                  DropdownMenuItem(child: Text('        1'), value: 1),
                  DropdownMenuItem(child: Text('        2'), value: 2),
                  DropdownMenuItem(child: Text('        3'), value: 3),
                  DropdownMenuItem(child: Text('        4'), value: 4),
                  DropdownMenuItem(child: Text('        5'), value: 5),
                  DropdownMenuItem(child: Text('        6'), value: 6),
                  DropdownMenuItem(child: Text('        7'), value: 7),
                  DropdownMenuItem(child: Text('        8'), value: 8),
                ],
                value: value1,
                onChanged: (value) => setState(() => value1 = value)),
            const SizedBox(height: 30.0),
            const Text("Enter the time."),
            const SizedBox(height: 5.0),
            TextField(
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
