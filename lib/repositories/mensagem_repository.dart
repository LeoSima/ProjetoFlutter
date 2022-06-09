import 'package:flutter/material.dart';
import '../models/mensagem.dart';

class MensagemRepository {
  static List<Mensagem> mensagens = [
    Mensagem(
      Foto: Icons.account_circle,
      Contato: 'User 1',
      CorpoMensagem: 'Blábláblá',
    ),
    Mensagem(
      Foto: Icons.account_circle,
      Contato: 'User 2',
      CorpoMensagem: 'Pipipipopopo',
    ),
    Mensagem(
      Foto: Icons.account_circle,
      Contato: 'User 2',
      CorpoMensagem: 'Teste',
    ),
  ];
}
