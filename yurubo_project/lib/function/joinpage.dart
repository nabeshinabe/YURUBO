import 'package:flutter/material.dart';
import 'package:yurubo/function/chatpage.dart' as chatpage;
import 'package:yurubo/function/add_joinpage.dart' as addjoinpage;

class JoinPage extends StatelessWidget {
  const JoinPage({super.key});
  Card show_join_card(restaurant, open_time, joined_people, context) {
    Card join_card = Card(
      child: Center(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 20.0),
            child: Row(
              children: [
                Column(
                  children: [
                    const SizedBox(height: 15),
                    ElevatedButton(
                      child: const Text(
                        "Join",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const chatpage.ChatPage()),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    restaurant,
                    style: const TextStyle(fontSize: 30),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      Text(
                        joined_people,
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(width: 100),
                      Text(
                        open_time,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  )
                ]),
              ],
            )),
      ),
    );

    return join_card;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 10),
          Center(
            child: ElevatedButton(
              child: const Text(
                "Add Restaurant",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const addjoinpage.AddJoinPage()),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          show_join_card("Restaurant_A", "17:00", "2/4", context),
          show_join_card("Restaurant_B", "18:00", "1/4", context),
          show_join_card("Restaurant_C", "18:30", "3/4", context),
        ],
      ),
    );
  }
}