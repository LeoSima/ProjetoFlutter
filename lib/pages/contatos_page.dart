import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../models/contato.dart';
import '../repositories/contato_repository.dart';

class ListaContatos extends StatefulWidget {
  const ListaContatos({Key? key}) : super(key: key);

  @override
  State<ListaContatos> createState() => _ListaContatosState();
}

class _ListaContatosState extends State<ListaContatos>
    with TickerProviderStateMixin {
  final contatos = ContatoRepository.contatos;
  bool showFAB = true;

  late final _controller = AnimationController(
    duration: const Duration(milliseconds: 400),
    vsync: this,
  )..forward();

  late final _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _animation.dispose();
  }

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
        title: Text(
          '${selecionados.length} selecionado(s)',
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
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
          selecionados.length == 1
              ? IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
                )
              : const SizedBox.shrink(),
        ],
      );
    }
  }

  bodyContatosPage() {
    return Column(
      children: [
        Expanded(
          child: NotificationListener<UserScrollNotification>(
            onNotification: (scroll) {
              if (scroll.direction == ScrollDirection.reverse && showFAB) {
                _controller.reverse();
                showFAB = false;
              } else if (scroll.direction == ScrollDirection.forward &&
                  !showFAB) {
                _controller.forward();
                showFAB = true;
              }
              return true;
            },
            child: listViewContatos(),
          ),
        ),
      ],
    );
  }

  listViewContatos() {
    return ListView.separated(
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
      itemCount: contatos.length,
    );
  }

  floatingActionButtonContatos() {
    if (selecionados.isEmpty) {
      return ScaleTransition(
        scale: _animation,
        child: FloatingActionButton(
          backgroundColor: Colors.grey.shade900,
          child: const Icon(
            Icons.person_add,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      );
    } else {
      return ScaleTransition(
        scale: _animation,
        child: FloatingActionButton(
          backgroundColor: Colors.grey.shade900,
          child: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarContatos(),
      body: bodyContatosPage(),
      floatingActionButton: floatingActionButtonContatos(),
    );
  }
}
