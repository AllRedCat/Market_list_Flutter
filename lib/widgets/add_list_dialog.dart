import 'package:flutter/material.dart';

class AddListDialog extends StatelessWidget {
  final void Function(String) onAdd;

  const AddListDialog({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    final Controller = TextEditingController();
    return AlertDialog(
      title: const Text('Adicionar nova lista'),
      content: TextField(
        controller: Controller,
        decoration: const InputDecoration(
          labelText: 'Nome da lista',
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            onAdd(Controller.text);
            Navigator.of(context).pop();
          },
          child: const Text('Adicionar'),
        ),
      ],
    );
  }
}
