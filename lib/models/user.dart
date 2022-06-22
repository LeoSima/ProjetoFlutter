import 'package:flutterchat/models/mensagem.dart';

class User {
  final String username;
  late String urlImagemPerfil = 'https://github.com/$username.png';
  List<Mensagem> mensagens = [];
  List<User> contatos = [];

  User({
    required this.username,
  });
}
