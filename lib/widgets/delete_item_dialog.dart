import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  final String itemName;
  final VoidCallback onConfirm;

  const DeleteDialog({
    super.key,
    required this.itemName,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirmar exclusão'),
      content: Text('Tem certeza que deseja excluir "$itemName"?'),
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