import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutterchat/models/user.dart';
import 'package:flutterchat/models/mensagem.dart';

class MensagemRepository extends ChangeNotifier {
  final List<Mensagem> _mensagens = [];

  UnmodifiableListView<Mensagem> get lista => UnmodifiableListView(_mensagens);

  saveAll(String corpoMensagem, User userEscritor, User userRecebedor) {
    Mensagem mensagem = Mensagem(
      corpoMensagem: corpoMensagem,
      userEscritor: userEscritor,
      userRecebedor: userRecebedor,
    );

    _mensagens.add(mensagem);

    userEscritor.mensagens.add(mensagem);
    userRecebedor.mensagens.add(mensagem);

    notifyListeners();
  }

  remove(List<Mensagem> mensagens, User userEscritor, User userRecebedor) {
    for (Mensagem mensagem in mensagens) {
      userEscritor.mensagens.remove(mensagem);
      userRecebedor.mensagens.remove(mensagem);
      _mensagens.remove(mensagem);
    }

    notifyListeners();
  }

  montaChat(User userAtivo, User contato) {
    List<Mensagem> mensagens = _mensagens
        .where((mensagem) =>
            (mensagem.userEscritor == userAtivo &&
                mensagem.userRecebedor == contato) ||
            (mensagem.userEscritor == contato &&
                mensagem.userRecebedor == userAtivo))
        .toList();

    mensagens.sort((a, b) {
      if (a.dataEnvio.compareTo(b.dataEnvio) < 0) return -1;
      if (a.dataEnvio.compareTo(b.dataEnvio) > 0) return 1;
      return 0;
    });

    return mensagens;
  }
}
