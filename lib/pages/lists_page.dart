import 'package:flutter/material.dart';
import 'package:market_list/pages/items_page.dart';
import 'package:market_list/widgets/list_item.dart';
import 'package:market_list/models/list.dart';
import 'package:market_list/widgets/delete_list_dialog.dart';
import 'package:market_list/widgets/add_list_dialog.dart';
import 'package:market_list/widgets/edit_list_dialog.dart';
import 'package:market_list/pages/menu_page.dart';
import 'package:market_list/services/firestore_service.dart';

class ListsPage extends StatefulWidget {
  const ListsPage({super.key});

  @override
  State<ListsPage> createState() => _ListsPageState();
}

class _ListsPageState extends State<ListsPage> {
  final FirestoreService _firestoreService = FirestoreService();

  void _addList(String name) async {
    if (name.trim().isEmpty) return;
    try {
      await _firestoreService.addList(name);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao adicionar lista: $e')),
        );
      }
    }
  }

  void _editList(ItemsList list, String newName) async {
    if (newName.trim().isEmpty) return;
    try {
      list.name = newName;
      await _firestoreService.updateList(list);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao editar lista: $e')),
        );
      }
    }
  }

  void _deleteList(String? id) async {
    if (id == null) return;
    try {
      await _firestoreService.deleteList(id);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao excluir lista: $e')),
        );
      }
    }
  }

  void _navigate(ItemsList list) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ListPage(listItems: list)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listas'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AccountPage()),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<List<ItemsList>>(
        stream: _firestoreService.getLists(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final itemLists = snapshot.data ?? [];

          if (itemLists.isEmpty) {
            return const Center(child: Text('Nenhuma lista encontrada.'));
          }

          return ListView.builder(
            itemCount: itemLists.length,
            itemBuilder: (context, index) {
              final list = itemLists[index];
              return ListItem(
                name: list.name,
                onToggle: () => _navigate(list),
                onToggleEdit: () {
                  showDialog(
                    context: context,
                    builder: (context) => EditListDialog(
                      onUpdate: (newName) => _editList(list, newName),
                      oldName: list.name,
                    ),
                  );
                },
                onToggleDelete: () {
                  showDialog(
                    context: context,
                    builder: (context) => DeleteListDialog(
                      name: list.name,
                      onConfirm: () => _deleteList(list.id),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AddListDialog(onAdd: _addList),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
