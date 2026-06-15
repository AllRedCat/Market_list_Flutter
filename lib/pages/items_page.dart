import 'package:flutter/material.dart';
import 'package:market_list/models/list.dart';
import 'package:market_list/services/firestore_service.dart';
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
  final ScrollController _scrollController = ScrollController();
  final FirestoreService _firestoreService = FirestoreService();

  void _saveChanges() async {
    try {
      await _firestoreService.updateList(widget.listItems);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar alterações: $e')),
        );
      }
    }
  }

  void _addItem(String name) {
    if (name.trim().isEmpty) return;
    setState(() {
      widget.listItems.items.add(Item(name: name));
    });
    _saveChanges();

    // Scroll para o final após adicionar o item
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _toggleItem(int index) {
    setState(() {
      widget.listItems.items[index].checked =
          !widget.listItems.items[index].checked;
    });
    _saveChanges();
  }

  void _deleteItem(int index) {
    setState(() {
      widget.listItems.items.removeAt(index);
    });
    _saveChanges();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.listItems.name), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: widget.listItems.items.length,
              itemBuilder: (context, index) {
                final item = widget.listItems.items[index];
                return ItemTile(
                  name: item.name,
                  checked: item.checked,
                  onToggle: () => _toggleItem(index),
                  onToggleDelete: () {
                    showDialog(
                      context: context,
                      builder: (context) => DeleteDialog(
                        itemName: item.name,
                        onConfirm: () => _deleteItem(index),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          AddItemField(onAdd: _addItem),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
