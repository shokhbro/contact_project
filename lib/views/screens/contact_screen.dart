import 'package:flutter/material.dart';
import 'package:lesson_21/controllers/contacts_controller.dart';
import 'package:lesson_21/views/widgets/contact_add.dart';
import 'package:lesson_21/views/widgets/contact_item.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final contactsController = ContactsController();

  void _deleteContact(int index) {
    contactsController.delete(index);
    setState(() {});
  }

  void _addOrEditContact({int? index}) async {
    Map<String, dynamic>? data = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) {
        return ContactAddDialog(
          initialName:
              index != null ? contactsController.list[index].name : null,
          initialPhone:
              index != null ? contactsController.list[index].phone : null,
        );
      },
    );

    if (data != null) {
      if (index != null) {
        contactsController.update(index, data['name'], data['phone']);
      } else {
        contactsController.add(data['name'], data['phone']);
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contacts"),
        actions: [
          IconButton(
            onPressed: () => _addOrEditContact(),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: contactsController.list.length,
        itemBuilder: (ctx, index) {
          return ContactItem(
            contactsController.list[index],
            onDelete: () => _deleteContact(index),
            onEdit: () => _addOrEditContact(index: index),
          );
        },
      ),
    );
  }
}
