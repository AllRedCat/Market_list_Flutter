import 'package:flutter/material.dart';
import '../widgets/add_item_field.dart';
import '../widgets/item_tile.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key, required this.title});

  final String title;

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final TextEditingController controller = TextEditingController();
  List<Map<String, dynamic>> items = [];

  void AddItem(String name) {
    setState(() {
      items.add({'name': name, 'checked': false});
    });
  }

  void ToggleItem(int index) {
    setState(() {
      items[index]['checked'] = !items[index]['checked'];
    });
  }

  void DeleteItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Lista de compras"),
      ),
      body: Column(
        children: [
          AddItemField(onAdd: AddItem),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ItemTile(
                  name: items[index]['name'],
                  checked: items[index]['checked'],
                  onToggle: () => ToggleItem(index),
                  onDelete: () => DeleteItem(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}