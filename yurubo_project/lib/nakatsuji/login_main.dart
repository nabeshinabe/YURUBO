import 'package:login/hello.dart';
import 'package:login/requester/requester.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ログイン画面',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(title: 'Login Page'),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userNameTextController = TextEditingController();
  final _passwordNameTextController = TextEditingController();
  final FocusNode _userNamefocusNode = FocusNode();
  final FocusNode _passwordNameFocusNode = FocusNode();
  var _errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_errorMessage, style: const TextStyle(color: Colors.red)),
            TextField(
              controller: _userNameTextController,
              decoration: const InputDecoration(
                filled: true,
                labelText: 'Username',
              ),
              focusNode: _userNamefocusNode,
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: _passwordNameTextController,
              decoration: const InputDecoration(
                filled: true,
                labelText: 'Password',
              ),
              focusNode: _passwordNameFocusNode,
              obscureText: true,
            ),
            ButtonBar(
              children: <Widget>[
                TextButton(
                  child: const Text('CANCEL'),
                  onPressed: () {
                    _userNameTextController.clear();
                    _passwordNameTextController.clear();
                  },
                ),
                ElevatedButton(
                    child: const Text('LOGIN'),
                    onPressed: () {
                      Requester()
                          .loginRequester(_userNameTextController.text,
                              _passwordNameTextController.text)
                          .then((_) {
                        setState(() {
                          _errorMessage = "";
                        });
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Hello()));
                      }).onError((error, stackTrace) {
                        debugPrint(error.toString());
                        _userNameTextController.clear();
                        _passwordNameTextController.clear();
                        setState(() {
                          _errorMessage = "ログインに失敗しました。ユーザー名かパスワードが間違っています。";
                        });
                      });
                    }),
                ElevatedButton(
                    child: const Text('SIGNUP'),
                    onPressed: () {
                      Requester()
                          .signUpRequester(_userNameTextController.text,
                              _passwordNameTextController.text)
                          .then((_) {
                        setState(() {
                          _errorMessage = "";
                        });
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Hello()));
                      }).onError((error, stackTrace) {
                        debugPrint(error.toString());
                        _userNameTextController.clear();
                        _passwordNameTextController.clear();
                        setState(() {
                          _errorMessage = "ユーザーの作成に失敗しました。既に登録済みのユーザーです。";
                        });
                      });
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}