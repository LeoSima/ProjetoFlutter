import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutterchat/models/user.dart';

class UsersRepository extends ChangeNotifier {
  final List<User> _users = [];

  UnmodifiableListView<User> get lista => UnmodifiableListView(_users);

  saveAll(String username) {
    bool hasUser = false;

    for (User user in _users) {
      if (user.username == username) {
        hasUser = true;
        break;
      }
    }

    if (!hasUser) _users.add(User(username: username));
  }

  saveNewContact(User user, String contactUsername) {
    bool hasContact = false;

    saveAll(contactUsername);

    User contact = _users.firstWhere((x) => x.username == contactUsername);

    for (User contactUser in user.contatos) {
      if (contactUser.username == contactUsername) {
        hasContact = true;
        break;
      }
    }

    if (!hasContact) user.contatos.add(contact);

    return !hasContact;
  }

  removeContact(User user, User contact) {
    user.contatos.remove(contact);
    notifyListeners();
  }
}