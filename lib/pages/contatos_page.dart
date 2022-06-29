// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:flutterchat/models/user.dart';
import 'package:flutterchat/pages/add_page.dart';
import 'package:flutterchat/pages/chat_page.dart';
import 'package:flutterchat/pages/login_page.dart';
import 'package:flutterchat/repositories/user_repository.dart';

enum Menu { item1 }

class ListaContatos extends StatefulWidget {
  final User user;

  const ListaContatos({Key? key, required this.user}) : super(key: key);

  @override
  State<ListaContatos> createState() => _ListaContatosState();
}

class _ListaContatosState extends State<ListaContatos>
    with TickerProviderStateMixin {
  late UsersRepository users;
  late List<User> allContatos = widget.user.contatos;
  List<User> contatos = [];
  bool showFAB = true;
  bool isSearching = false;

  late final _controller = AnimationController(
    duration: const Duration(milliseconds: 400),
    vsync: this,
  )..forward();

  late final _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void initState() {
    contatos = allContatos;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _animation.dispose();
  }

  List<User> selecionados = [];

  appBarContatos() {
    if (isSearching) {
      return AppBar(
        backgroundColor: Colors.grey.shade900,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () => setState(() {
            isSearching = false;
            contatos = allContatos;
          }),
        ),
        title: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 16.0),
          child: TextField(
            onChanged: (searchVal) => searchContato(searchVal),
            style: const TextStyle(fontSize: 20),
            decoration: const InputDecoration(hintText: 'Pesquisar'),
          ),
        ),
      );
    } else if (selecionados.isEmpty) {
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
        actions: actionAppBar(),
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
        actions: actionAppBar(),
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
        return contatos.isEmpty
            ? const ListTile(
                leading: Icon(Icons.no_accounts),
                title: Text(
                  'Ainda não há contatos adicionados',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              )
            : ListTile(
                leading: selecionados.contains(contatos[contato])
                    ? const CircleAvatar(
                        backgroundColor: Colors.green,
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      )
                    : SizedBox(
                        width: 40,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24.0),
                          child:
                              Image.network(contatos[contato].urlImagemPerfil),
                        ),
                      ),
                title: Text(
                  contatos[contato].username,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                selected: selecionados.contains(contatos[contato]),
                selectedTileColor: Colors.indigo.shade200,
                onTap: () {
                  if (selecionados.isNotEmpty) {
                    setState(() {
                      selecionados.contains(contatos[contato])
                          ? selecionados.remove(contatos[contato])
                          : selecionados.add(contatos[contato]);
                    });
                  } else {
                    abrirConversa(contatos[contato]);
                  }
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
        thickness: 2.25,
        height: 0.0,
        indent: 2.0,
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
          onPressed: () {
            abrirAddPage();
          },
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
          onPressed: () {
            users.removeContact(widget.user, selecionados);
            setState(() {
              selecionados = [];
            });
          },
        ),
      );
    }
  }

  abrirConversa(User contato) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Chat(user: widget.user, contato: contato),
      ),
    );
  }

  showAlertDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Já está saindo?'),
            content: const Text('Tem certeza de que quer sair do aplicativo?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Ficar'),
              ),
              TextButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const Login(),
                    )),
                child: const Text('Sair'),
              ),
            ],
          );
        });
  }

  actionAppBar() {
    if (selecionados.isEmpty) {
      return [
        IconButton(
          onPressed: () => setState(() {
            isSearching = true;
          }),
          icon: const Icon(Icons.search),
        ),
        PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem<Menu>(
              value: Menu.item1,
              child: TextButton(
                child: const Text(
                  'Sair',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                onPressed: () {
                  showAlertDialog();
                },
              ),
            )
          ],
        ),
      ];
    } else {
      return [
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
      ];
    }
  }

  abrirAddPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddContato(user: widget.user),
      ),
    );
  }

  void searchContato(String searchVal) {
    List<User> res = [];

    if (searchVal.isEmpty) {
      res = allContatos;
    } else {
      res = allContatos
          .where((contato) =>
              contato.username.toLowerCase().contains(searchVal.toLowerCase()))
          .toList();
    }

    setState(() {
      contatos = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    users = context.watch<UsersRepository>();

    return Scaffold(
      appBar: appBarContatos(),
      body: bodyContatosPage(),
      floatingActionButton: floatingActionButtonContatos(),
    );
  }
}
