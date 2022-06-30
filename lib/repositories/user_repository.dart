import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutterchat/models/user.dart';

class UsersRepository extends ChangeNotifier {
  final List<User> _users = [];
  late FirebaseFirestore db;

  UsersRepository() {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
    await _readUsers();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  _readUsers() async{
    if(_mensagens.isEmpty) {
      final snapshot = await db.collection('users').get();
      snapshot.docs.forEach((doc) {
        User user = UsersRepository.tabela.firstWhere((user) => user.username == doc.get('username'));
        _users.add(user);
        notifyListeners();
      })
    }
  }

  UnmodifiableListView<User> get lista => UnmodifiableListView(_users);

  saveAll(String username) {
    bool hasUser = false;

    for (User user in _users) {
      if (user.username.toLowerCase() == username.toLowerCase()) {
        hasUser = true;
        break;
      }
    }

    if (!hasUser) async{
      _users.add(User(username: username));
      User newUser = findUserByUsername(username);

      await db.collection('users')
      .doc(newUser.username)
      .set({
        'username': newUser.username,
        'urlImagemPerfil': newUser.urlImagemPerfil
      })
    }
    notifyListeners();
  }

  saveNewContact(User user, String contactUsername) {
    bool hasContact = false;

    saveAll(contactUsername);

    User contact = findUserByUsername(contactUsername);

    for (User contactUser in user.contatos) {
      if (contactUser.username.toLowerCase() == contactUsername.toLowerCase()) {
        hasContact = true;
        break;
      }
    }

    if (!hasContact) {
      user.contatos.add(contact);
      contact.contatos.add(user);
    }

    notifyListeners();
    return !hasContact;
  }

  removeContact(User user, List<User> contacts) {
    for (User contact in contacts) {
      user.contatos.remove(contact);
      contact.contatos.remove(user);
    }
    notifyListeners();
  }

  findUserByUsername(String username) {
    User user = _users.firstWhere((user) => username.toLowerCase() == user.username.toLowerCase());
    return user;
  }
}
