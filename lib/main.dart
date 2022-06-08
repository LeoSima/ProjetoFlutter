import 'package:flutter/material.dart';
import 'package:flutterchat/pages/contatos_page.dart';
import 'pages/chat_page.dart';

// void main() {
//   runApp(const MyApp());
// }

void main() => runApp(const FlutterChatApp());

class FlutterChatApp extends StatelessWidget {
  const FlutterChatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blueGrey,
      ),
      home: Chat(),
      debugShowCheckedModeBanner: false,
    );
  }
}
