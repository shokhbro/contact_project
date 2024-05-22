import 'package:flutter/material.dart';
import 'package:lesson_21/models/contact.dart';

class ContactsController {
  final List<Contact> _contacts = [];

  List<Contact> get list => _contacts;

  void add(String name, String phone) {
    _contacts.add(Contact(name: name, phone: phone, color: Colors.primaries[_contacts.length % Colors.primaries.length]));
  }

  void update(int index, String name, String phone) {
    _contacts[index] = Contact(name: name, phone: phone, color: _contacts[index].color);
  }

  void delete(int index) {
    _contacts.removeAt(index);
  }
}
