import 'package:flutter/material.dart';

class EditListDialog extends StatelessWidget {
  final void Function(String) onUpdate;
  final String oldName;

  const EditListDialog({super.key, required this.onUpdate, required this.oldName});

  @override
  Widget build(BuildContext context) {
    final Controller = TextEditingController(text: oldName);
    return AlertDialog(
      title: const Text('Alterar nome da lista'),
      content: TextField(
        controller: Controller,
        decoration: const InputDecoration(
          hintText: 'Nome da lista',
          border: OutlineInputBorder(),
        ),
        onSubmitted: (value) {
          onUpdate(Controller.text);
          Navigator.of(context).pop();
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            onUpdate(Controller.text);
            Navigator.of(context).pop();
          },
          child: const Text('Adicionar'),
        ),
      ],
    );
  }
}
