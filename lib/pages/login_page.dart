import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutterchat/pages/contatos_page.dart';
import 'package:flutterchat/repositories/user_repository.dart';
import 'package:flutterchat/pages/widgets/textButtonIcon.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String username = '';
  bool isValidUsername = false;

  bodyImagemPerfil() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35.0),
        child: username == ''
            ? Builder(builder: (context) {
                isValidUsername = false;
                return const Center(
                  child: Text(
                    'Insira seu nome de usuário do GitHub',
                    style: TextStyle(fontSize: 18),
                  ),
                );
              })
            : Image.network(
                'https://github.com/$username.png',
                width: 360,
                height: 360,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    isValidUsername = true;
                    return child;
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                errorBuilder: (context, exception, stackTrace) {
                  isValidUsername = false;
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
            username = value;
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
      padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 0.0),
      child: TextButtonIcon(
        icon: Icons.login,
        label: 'Login',
        onPressed: () {
          isValidUsername
              ? logar(username)
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
    return ChangeNotifierProvider(
      create: (context) => UsersRepository(),
      child: Scaffold(
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
      ),
    );
  }
}
