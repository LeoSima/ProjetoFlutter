import 'package:flutter/material.dart';
import '../models/contato.dart';
import '../repositories/contato_repository.dart';

class ListaContatos extends StatefulWidget {
  const ListaContatos({Key? key}) : super(key: key);

  @override
  State<ListaContatos> createState() => _ListaContatosState();
}

class _ListaContatosState extends State<ListaContatos> {
  final contatos = ContatoRepository.contatos;

  List<Contato> selecionados = [];

  appBarContatos() {
    if (selecionados.isEmpty) {
      return AppBar(
        backgroundColor: Colors.grey.shade900,
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
      );
    } else {
      return AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              selecionados = [];
            });
          },
        ),
        title: Text('${selecionados.length} selecionados'),
        actions: [
          // selecionados.length == 1
          //     ? IconButton(onPressed: () {}, icon: Icon(Icons.edit),)
          //     : null,
          selecionados.length == contatos.length
              ? Row(
                  children: [
                    const Text('Selecionar todos'),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          selecionados = [];
                        });
                      },
                      icon: const Icon(Icons.check_box),
                    ),
                  ],
                )
              : Row(
                  children: [
                    const Text('Selecionar todos'),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          for (var i = 0; i < contatos.length; i++) {
                            selecionados.contains(contatos[i])
                                ? null
                                : selecionados.add(contatos[i]);
                          }
                        });
                      },
                      icon: const Icon(Icons.check_box_outline_blank),
                    ),
                  ],
                ),
            
        ],
      );
    }
  }

  floatingActionButtonContatos() {
    if (selecionados.isEmpty) {
      return FloatingActionButton(
        backgroundColor: Colors.grey.shade900,
        child: const Icon(
          Icons.person_add,
          color: Colors.white,
        ),
        onPressed: () {},
      );
    } else {
      return FloatingActionButton(
        backgroundColor: Colors.grey.shade900,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
        onPressed: () {},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarContatos(),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
                itemBuilder: (BuildContext context, int contato) {
                  return ListTile(
                    leading: selecionados.contains(contatos[contato])
                        ? const CircleAvatar(
                            backgroundColor: Colors.green,
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                          )
                        : SizedBox(
                            width: 50,
                            child: Icon(contatos[contato].Foto),
                          ),
                    title: Text(
                      contatos[contato].NomeContato,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      contatos[contato].UltimaMensagem,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.white70,
                      ),
                    ),
                    selected: selecionados.contains(contatos[contato]),
                    selectedTileColor: Colors.indigo.shade200,
                    onTap: () {
                      setState(() {
                        if (selecionados.isNotEmpty) {
                          selecionados.contains(contatos[contato])
                              ? selecionados.remove(contatos[contato])
                              : selecionados.add(contatos[contato]);
                        }
                      });
                    },
                    onLongPress: () {
                      setState(() {
                        selecionados.contains(contatos[contato])
                            ? selecionados.remove(contatos[contato])
                            : selecionados.add(contatos[contato]);
                      });
                    },
                  );
                },
                separatorBuilder: (_, ___) => Divider(
                      color: Colors.grey.shade900,
                      thickness: 1.5,
                      height: 0.0,
                      indent: 0.0,
                      endIndent: 0.0,
                    ),
                itemCount: contatos.length),
          ),
        ],
      ),
      floatingActionButton: floatingActionButtonContatos(),
    );
  }
}
