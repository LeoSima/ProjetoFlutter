import 'package:flutter/material.dart';
import 'package:flutterchat/repositories/contato_repository.dart';

class ListaContatos extends StatelessWidget {
  ListaContatos({Key? key}) : super(key: key);

  final contatos = ContatoRepository.contatos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {},
            );
          },
        ),
        title: const Text('Flutter Chat'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert_rounded),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
                itemBuilder: (BuildContext context, int contato) {
                  return Card(
                    margin: const EdgeInsets.all(1.75),
                    child: ListTile(
                      leading: contatos[contato].Foto,
                      title: Text(contatos[contato].NomeContato),
                      subtitle: Text(contatos[contato].UltimaMensagem),
                    ),
                  );
                },
                separatorBuilder: (_,___) => Divider(),
                itemCount: contatos.length),
          ),
        ],
      ),
      // Column(
      //   children: [
      //     const Padding(padding: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 0.0)),
      //     ItemContato(Contato('User 1', 'Last Message')),
      //     ItemContato(Contato('User 2', 'Last Message')),
      //     ItemContato(Contato('User 3', 'Last Message')),
      //     ItemContato(Contato('User 3', 'Last Message')),
      //     ItemContato(Contato('User 3', 'Last Message')),
      //     ItemContato(Contato('User 3', 'Last Message')),
      //     ItemContato(Contato('User 3', 'Last Message')),
      //     ItemContato(Contato('User 3', 'Last Message')),
      //     ItemContato(Contato('User 3', 'Last Message')),
      //     ItemContato(Contato('User 3', 'Last Message')),
      //     ItemContato(Contato('User 3', 'Last Message')),
      //     ItemContato(Contato('User 3', 'Last Message')),
      //     ItemContato(Contato('User 3', 'Last Message')),
      //   ],
      // ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey.shade900,
        child: const Icon(
          Icons.chat_outlined,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
    );
  }
}
