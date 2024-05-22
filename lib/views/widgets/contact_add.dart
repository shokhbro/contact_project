import 'package:flutter/material.dart';

class ContactAddDialog extends StatefulWidget {
  final String? initialName;
  final String? initialPhone;

  const ContactAddDialog({
    super.key,
    this.initialName,
    this.initialPhone,
  });

  @override
  State<ContactAddDialog> createState() => _ContactAddDialogState();
}

class _ContactAddDialogState extends State<ContactAddDialog> {
  final _formKey = GlobalKey<FormState>();

  late String name;
  late String phone;

  @override
  void initState() {
    super.initState();
    name = widget.initialName ?? "";
    phone = widget.initialPhone ?? "";
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Navigator.pop(context, {
        "name": name,
        "phone": phone,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Kontakt qo'shish / Tahrirlash"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: name,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Ism",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Iltimos ism kiriting";
                }

                return null;
              },
              onSaved: (newValue) {
                name = newValue ?? "";
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: phone,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Telefon raqam",
                prefixIcon: Icon(Icons.add),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Iltimos telefon raqam kiriting";
                } else if (!RegExp(r"^\d+$").hasMatch(value)) {
                  return "Iltimos to'g'ri telefon raqam kiriting";
                }

                return null;
              },
              onSaved: (newValue) {
                phone = newValue ?? "";
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Bekor qilish"),
        ),
        ElevatedButton(
          onPressed: _save,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          child: const Text("Saqlash"),
        ),
      ],
    );
  }
}
