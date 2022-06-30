import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutterchat/models/user.dart';
import 'package:flutterchat/models/mensagem.dart';

class MensagemRepository extends ChangeNotifier {
  final List<Mensagem> _mensagens = [];
  late FirebaseFirestore db;

  MensagemRepository() {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
    await _readFavoritas();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  _readFavoritas() async{
    if(_mensagens.isEmpty) {
      final snapshot = await db.collection('mensagens').get();
      snapshot.docs.forEach((doc) {
        //Montar mensagem.id
      })
    }
  }

  UnmodifiableListView<Mensagem> get lista => UnmodifiableListView(_mensagens);

  saveAll(String corpoMensagem, User userEscritor, User userRecebedor) async{
    Mensagem mensagem = Mensagem(
      corpoMensagem: corpoMensagem,
      userEscritor: userEscritor,
      userRecebedor: userRecebedor,
    );

    _mensagens.add(mensagem);
    userEscritor.mensagens.add(mensagem);
    userRecebedor.mensagens.add(mensagem);

    await db.collection('mensagens')
    .doc()
    .set({
      'corpoMensagem': mensagem.corpoMensagem,
      'userEscritor': mensagem.userEscritor,
      'usereRecebedor': mensagem.usereRecebedor,
      'dataEnvio': mensagem.dataEnvio
    })

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
