import 'package:flutter/material.dart';

class ItemTile extends StatelessWidget {
  final String name;
  final bool checked;
  final VoidCallback onToggle;
  final VoidCallback onToggleDelete;
  // final VoidCallback onDelete;

  const ItemTile({
    super.key,
    required this.name,
    required this.checked,
    required this.onToggle,
    required this.onToggleDelete,
    // required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(value: checked, onChanged: (_) => onToggle()),
      title: Text(
        name,
        style: TextStyle(
          decoration: checked ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: onToggleDelete,
      ),
      onTap: onToggle,
    );
  }
}