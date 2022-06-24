import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutterchat/models/user.dart';
import 'package:flutterchat/models/mensagem.dart';
import 'package:flutterchat/repositories/mensagem_repository.dart';

class Chat extends StatefulWidget {
  final User user;
  final User contato;

  const Chat({Key? key, required this.user, required this.contato})
      : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  late MensagemRepository allMensagens;
  List<Mensagem> mensagensChat = [];

  List<Mensagem> selecionadas = [];

  appBarMensagens() {
    if (selecionadas.isEmpty) {
      return AppBar(
        backgroundColor: Colors.grey.shade900,
        titleSpacing: 0.0,
        leading: const BackButton(),
        title: Row(
          children: [
            SizedBox(
              width: 60,
              child: Image.network(widget.contato.urlImagemPerfil),
            ),
            Expanded(
              child: Text(widget.contato.username),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert_rounded),
          ),
        ],
      );
    } else {
      return AppBar(
        backgroundColor: Colors.grey.shade900,
        titleSpacing: 0.0,
        leading: IconButton(
          onPressed: () {
            setState(() {
              selecionadas = [];
            });
          },
          icon: const Icon(Icons.close),
        ),
        title: Text('${selecionadas.length} selecionada(s)'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete),
          ),
        ],
      );
    }
  }

  bodyMensagensPage() {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: listViewMensagens(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
              child: textFieldMensagem(),
            ),
          ),
        ],
      ),
    );
  }

  listViewMensagens() {
    return ListView.separated(
      itemBuilder: (BuildContext context, int mensagem) {
        return Card(
          margin: const EdgeInsets.all(0.0),
          child: ListTile(
            leading: SizedBox(
              width: 40,
              child: Image.network(
                  mensagensChat[mensagem].userEscritor.urlImagemPerfil),
            ),
            title: Text(
              mensagensChat[mensagem].userEscritor.username,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white70,
              ),
            ),
            subtitle: Text(
              mensagensChat[mensagem].corpoMensagem,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
            trailing: Text(
              mensagensChat[mensagem].dataFormatada +
                  mensagensChat[mensagem].horaFormatada,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
                color: Colors.white70,
              ),
            ),
            selected: selecionadas.contains(mensagensChat[mensagem]),
            selectedTileColor: Colors.indigo.shade200,
            onTap: () {
              setState(() {
                if (selecionadas.isNotEmpty) {
                  selecionadas.contains(mensagensChat[mensagem])
                      ? selecionadas.remove(mensagensChat[mensagem])
                      : selecionadas.add(mensagensChat[mensagem]);
                }
              });
            },
            onLongPress: () {
              setState(() {
                selecionadas.contains(mensagensChat[mensagem])
                    ? selecionadas.remove(mensagensChat[mensagem])
                    : selecionadas.add(mensagensChat[mensagem]);
              });
            },
          ),
        );
      },
      separatorBuilder: (_, ___) => Divider(
        color: Colors.grey.shade900,
        thickness: 1.0,
        height: 2.5,
        indent: 0.0,
        endIndent: 0.0,
      ),
      itemCount: mensagensChat.length,
    );
  }

  textFieldMensagem() {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.black54,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0)),
        hintText: 'Insira uma mensagem...',
        suffixIcon: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.emoji_emotions),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.send),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    allMensagens = Provider.of<MensagemRepository>(context);
    mensagensChat = allMensagens.montaChat(widget.user, widget.contato);

    return Scaffold(
      appBar: appBarMensagens(),
      body: bodyMensagensPage(),
    );
  }
}
