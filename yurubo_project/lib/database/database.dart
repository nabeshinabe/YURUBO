import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yurubo/function/loginpage.dart' as loginpage;


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // .envを読み込めるように設定.
  await dotenv.load(fileName: '.env');
  await Supabase.initialize(
    url: dotenv.get('VAR_URL'), // .envのURLを取得.
    anonKey: dotenv.get('VAR_ANONKEY'), // .envのanonキーを取得.
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YURUBO',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const loginpage.LoginPage(),
    );
  }
}