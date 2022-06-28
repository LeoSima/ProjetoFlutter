import 'package:flutter/material.dart';
import 'package:flutterchat/repositories/mensagem_repository.dart';
import 'package:provider/provider.dart';
import 'package:flutterchat/pages/login_page.dart';
import 'package:flutterchat/repositories/user_repository.dart';

// void main() {
//   runApp(const MyApp());
// }

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => UsersRepository(),
          ),
          ChangeNotifierProvider(
            create: (context) => MensagemRepository(),
          ),
        ],
        child: const FlutterChatApp(),
      ),
    );

class FlutterChatApp extends StatelessWidget {
  const FlutterChatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blueGrey,
      ),
      home: const Login(),
      debugShowCheckedModeBanner: false,
    );
  }
}
