import 'package:flutter/material.dart';
import 'package:flutterchat/pages/contatos_page.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String nick = '';
  bool isValidNick = false;

  bodyImagemPerfil() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35.0),
        child: nick == ''
            ? Builder(builder: (context) {
                isValidNick = false;
                return const Center(
                  child: Text(
                    'Insira seu nome de usuário do GitHub',
                    style: TextStyle(fontSize: 18),
                  ),
                );
              })
            : Image.network(
                'https://github.com/$nick.png',
                width: 360,
                height: 360,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  isValidNick = true;

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                errorBuilder: (context, exception, stackTrace) {
                  isValidNick = false;
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
            nick = value;
          })
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.black54,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0)),
          hintText: 'Seu nick do github...',
        ),
      ),
    );
  }

  bodyLoginButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
      child: TextButton.icon(
        onPressed: () {
          isValidNick
              ? logar(nick)
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
        icon: const Icon(Icons.login),
        label: const Text('Login'),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.black26),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
              side: const BorderSide(color: Colors.black45),
            ),
          ),
        ),
      ),
    );
  }

  logar(String user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ListaContatos(user: user),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: const Text('Flutter Chat'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              bodyImagemPerfil(),
              bodyTextField(),
              bodyLoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}
