import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final String name;
  final VoidCallback onToggle;
  final VoidCallback onToggleEdit;
  final VoidCallback onToggleDelete;

  const ListItem({
    super.key,
    required this.name,
    required this.onToggle,
    required this.onToggleEdit,
    required this.onToggleDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: const Color.fromARGB(20, 127, 127, 127),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18.0,
          vertical: 14.0,
        ),
        title: Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onToggleEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onToggleDelete,
            ),
          ],
        ),
        onTap: onToggle,
      ),
    );
  }
}
