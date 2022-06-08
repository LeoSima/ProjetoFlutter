import 'package:flutter/material.dart';
import '../models/contato.dart';

class ContatoRepository {
  static List<Contato> contatos = [
    Contato(
      Foto: const Icon(Icons.account_circle),
      NomeContato: 'User 1',
      UltimaMensagem: 'Last Message',
    ),
    Contato(
      Foto: const Icon(Icons.account_circle),
      NomeContato: 'User 2',
      UltimaMensagem: 'Last Message',
    ),
    Contato(
      Foto: const Icon(Icons.account_circle),
      NomeContato: 'User 3',
      UltimaMensagem: 'Last Message',
    ),
    Contato(
      Foto: const Icon(Icons.account_circle),
      NomeContato: 'User 4',
      UltimaMensagem: 'Last Message',
    ),
  ];
}
