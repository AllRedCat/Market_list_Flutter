import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/item.dart';
import '../widgets/add_item_field.dart';
import '../widgets/item_tile.dart';
import '../widgets/delete_item_dialog.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key, required this.title});

  final String title;

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final TextEditingController controller = TextEditingController();
  List<Item> items = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('items');
    if (jsonString != null && jsonString.isNotEmpty) {
      final List decoded = jsonDecode(jsonString) as List;
      setState(() {
        items = decoded
            .map((e) => Item.fromJson(e as Map<String, dynamic>))
            .toList();
      });
    }
  }

  Future<void> _saveItems() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(items.map((e) => e.toJson()).toList());
    await prefs.setString('items', jsonString);
  }

  void AddItem(String name) {
    if (name.trim().isEmpty) return;
    setState(() {
      items.add(Item(name: name));
    });
    _saveItems();
  }

  void ToggleItem(int index) {
    setState(() {
      items[index].checked = !items[index].checked;
    });
    _saveItems();
  }

  void DeleteItem(int index) {
    setState(() {
      items.removeAt(index);
    });
    _saveItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lista de compras")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ItemTile(
                  name: items[index].name,
                  checked: items[index].checked,
                  onToggle: () => ToggleItem(index),
                  onToggleDelete: () {
                    showDialog(
                      context: context,
                      builder: (context) => DeleteDialog(
                        itemName: items[index].name,
                        onConfirm: () => DeleteItem(index),
                      ),
                    );
                  },
                  // onDelete: () => DeleteItem(index),
                );
              },
            ),
          ),
          AddItemField(onAdd: AddItem),
        ],
      ),
    );
  }
}
