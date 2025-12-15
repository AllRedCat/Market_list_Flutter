import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:market_list/models/list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/item.dart';
import '../widgets/add_item_field.dart';
import '../widgets/item_tile.dart';
import '../widgets/delete_item_dialog.dart';

class ListPage extends StatefulWidget {
  final ItemsList listItems;

  const ListPage({super.key, required this.listItems});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final TextEditingController controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('lists');
    if (jsonString != null && jsonString.isNotEmpty) {
      final List decoded = jsonDecode(jsonString) as List;
      final lists = decoded.map((e) => ItemsList.fromJson(e)).toList();
      final currentList = lists.firstWhere(
        (list) => list.name == widget.listItems.name,
        orElse: () => widget.listItems,
      );
      setState(() {
        widget.listItems.items = currentList.items;
      });
    }
  }

  Future<void> _saveItems() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('lists');
    if (jsonString != null && jsonString.isNotEmpty) {
      final List decoded = jsonDecode(jsonString) as List;
      final lists = decoded.map((e) => ItemsList.fromJson(e)).toList();
      final index = lists.indexWhere((list) => list.name == widget.listItems.name);
      if (index != -1) {
        lists[index].items = widget.listItems.items;
        final updatedJson = jsonEncode(lists.map((e) => e.toJson()).toList());
        await prefs.setString('lists', updatedJson);
      }
    }
  }

  void AddItem(String name) {
    if (name.trim().isEmpty) return;
    setState(() {
      widget.listItems.items.add(Item(name: name));
    });
    _saveItems();
    
    // Scroll para o final após adicionar o item
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void ToggleItem(int index) {
    setState(() {
      widget.listItems.items[index].checked = !widget.listItems.items[index].checked;
    });
    _saveItems();
  }

  void DeleteItem(int index) {
    setState(() {
      widget.listItems.items.removeAt(index);
    });
    _saveItems();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lista de compras")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: widget.listItems.items.length,
              itemBuilder: (context, index) {
                return ItemTile(
                  name: widget.listItems.items[index].name,
                  checked: widget.listItems.items[index].checked,
                  onToggle: () => ToggleItem(index),
                  onToggleDelete: () {
                    showDialog(
                      context: context,
                      builder: (context) => DeleteDialog(
                        itemName: widget.listItems.items[index].name,
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
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
