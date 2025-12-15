import 'package:flutter/material.dart';

class DeleteListDialog extends StatelessWidget {
  final String name;
  final VoidCallback onConfirm;

  const DeleteListDialog({
    super.key,
    required this.name,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirmar exclusão'),
      content: Text('Tem certeza que deseja excluir a lista "$name"?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop();
          },
          child: const Text('Excluir'),
        ),
      ],
    );
  }
}