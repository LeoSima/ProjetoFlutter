import 'package:flutter/material.dart';
import 'package:flutterchat/pages/widgets/textButtonIcon.dart';

class AddContato extends StatefulWidget {
  const AddContato({Key? key}) : super(key: key);

  @override
  State<AddContato> createState() => _AddContatoState();
}

class _AddContatoState extends State<AddContato> {
  String addNick = '';
  bool isValidAddNick = false;

  bodyImagemPerfil() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35.0),
        child: addNick == ''
            ? Builder(builder: (context) {
                isValidAddNick = false;
                return const Center(
                  child: Text(
                    'Insira o nome de usuário do GitHub',
                    style: TextStyle(fontSize: 18),
                  ),
                );
              })
            : Image.network(
                'https://github.com/$addNick.png',
                width: 360,
                height: 360,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    isValidAddNick = true;
                    return child;
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                errorBuilder: (context, exception, stackTrace) {
                  isValidAddNick = false;
                  return const Center(
                    child: Text(
                      "Perfil não encontrado.\nVerifique e tente novamente.",
                      style: TextStyle(fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
      ),
    );
  }

  bodyTextField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 0.0),
      child: TextField(
        onChanged: (value) => {
          setState(() {
            addNick = value;
          })
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.black54,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0)),
          hintText: 'Nick do github...',
        ),
      ),
    );
  }

  bodyAddButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 0.0),
      child: TextButtonIcon(
        icon: Icons.person,
        label: 'Adicionar',
        onPressed: () {
          isValidAddNick
              ? addUser(addNick)
              : ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    action: SnackBarAction(
                      label: 'Okay',
                      onPressed: () {},
                    ),
                    content: const Text(
                      'Usuário informado inválido!',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                    ),
                    duration: const Duration(milliseconds: 2500),
                    backgroundColor: Colors.black54,
                  ),
                );
        },
      ),
    );
  }

  addUser(String nick) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: const Text('Adicionar contato'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              bodyImagemPerfil(),
              bodyTextField(),
              bodyAddButton(),
            ],
          ),
        ),
      ),
    );
  }
}