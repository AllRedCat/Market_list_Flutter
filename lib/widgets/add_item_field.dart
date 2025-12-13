import 'package:flutter/material.dart';

class AddItemField extends StatelessWidget {
  final void Function(String) onAdd;

  const AddItemField({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    final Controller = TextEditingController();

    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: Controller,
              decoration: const InputDecoration(
                labelText: 'Adicionar item',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                onAdd(Controller.text);
                Controller.clear();
              },
            ),
          ),
          const SizedBox(width: 8.0),
          Container(
            decoration: const ShapeDecoration(
              color: Colors.lightBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
            ),
            child: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                onAdd(Controller.text);
                Controller.clear();
              },
            ),
          ),
        ],
      ),
    );
  }
}
