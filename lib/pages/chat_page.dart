import 'package:flutter/material.dart';
import 'package:flutterchat/models/mensagem.dart';
import 'package:flutterchat/repositories/mensagem_repository.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final mensagens = MensagemRepository.mensagens;

  List<Mensagem> selecionadas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        titleSpacing: 0.0,
        title: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_back),
            ),
            Stack(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.account_circle),
                ),
              ],
            ),
            const Expanded(
              child: Text('User'),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.separated(
                itemBuilder: (BuildContext context, int mensagem) {
                  return Card(
                    margin: const EdgeInsets.all(0.0),
                    child: ListTile(
                      leading: SizedBox(
                        width: 40,
                        child: Icon(
                          mensagens[mensagem].Foto,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        mensagens[mensagem].Contato,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white70,
                        ),
                      ),
                      subtitle: Text(
                        mensagens[mensagem].CorpoMensagem,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                      selected: selecionadas.contains(mensagens[mensagem]),
                      selectedTileColor: Colors.indigo.shade200,
                      onTap: () {
                        setState(() {
                          if (selecionadas.isNotEmpty) {
                            selecionadas.contains(mensagens[mensagem])
                                ? selecionadas.remove(mensagens[mensagem])
                                : selecionadas.add(mensagens[mensagem]);
                          }
                        });
                      },
                      onLongPress: () {
                        setState(() {
                          selecionadas.contains(mensagens[mensagem])
                              ? selecionadas.remove(mensagens[mensagem])
                              : selecionadas.add(mensagens[mensagem]);
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
                itemCount: mensagens.length,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black54,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0)),
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
