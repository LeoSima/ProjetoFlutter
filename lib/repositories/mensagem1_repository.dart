import 'package:flutter/material.dart';
import '../models/mensagem1.dart';

class MessageRepository {
  static List<Message> mensagens = [
    Message(
      Foto: Icons.account_circle,
      Contato: 'User 1',
      CorpoMensagem: 'Blábláblá',
    ),
    Message(
      Foto: Icons.account_circle,
      Contato: 'User 2',
      CorpoMensagem: 'Pipipipopopo',
    ),
    Message(
      Foto: Icons.account_circle,
      Contato: 'User 2',
      CorpoMensagem: 'Teste',
    ),
  ];
}
