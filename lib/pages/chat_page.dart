import 'package:flutter/material.dart';
import 'package:flutterchat/repositories/mensagem_repository.dart';

class Chat extends StatelessWidget {
  Chat({Key? key}) : super(key: key);

  final mensagens = MensagemRepository.mensagens;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                      leading: mensagens[mensagem].Foto,
                      title: Text(mensagens[mensagem].Contato),
                      subtitle: Text(mensagens[mensagem].CorpoMensagem),
                    ),
                  );
                },
                separatorBuilder: (_, ___) => Divider(),
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
                        borderRadius: BorderRadius.circular(10.0)),
                    hintText: 'Insira uma mensagem...',
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.send),
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
