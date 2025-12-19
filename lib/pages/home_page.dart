import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:market_list/pages/market_list_page.dart';
import 'package:market_list/widgets/list_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:market_list/models/list.dart';
import 'package:market_list/widgets/delete_list_dialog.dart';
import 'package:market_list/widgets/add_list_dialog.dart';
import 'package:market_list/widgets/edit_list_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ItemsList> itemLists = [];
  @override
  void initState() {
    super.initState();
    _loadLists();
  }

  Future<void> _loadLists() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('lists');
    if (jsonString != null && jsonString.isNotEmpty) {
      final List decoded = jsonDecode(jsonString) as List;
      setState(() {
        itemLists = decoded.map((e) => ItemsList.fromJson(e)).toList();
      });
    }
  }

  Future<void> _saveLists() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(itemLists.map((e) => e.toJson()).toList());
    await prefs.setString('lists', jsonString);
  }

  void AddList(String name) {
    if (name.trim().isEmpty) return;
    setState(() {
      itemLists.add(ItemsList(name: name));
    });
    _saveLists();
  }

  void EditList(int index, String newName) {
    if (newName.trim().isEmpty) return;
    setState(() {
      itemLists[index].name = newName;
    });
    _saveLists();
  }

  void DeleteList(int index) {
    setState(() {
      itemLists.removeAt(index);
    });
    _saveLists();
  }

  void navigate(i) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ListPage(listItems: i)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listas'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: itemLists.length,
              itemBuilder: (context, index) {
                return ListItem(
                  name: itemLists[index].name,
                  onToggle: () => navigate(itemLists[index]),
                  onToggleEdit: () {
                    showDialog(
                      context: context,
                      builder: (context) => EditListDialog(
                        onUpdate: (newName) => EditList(index, newName),
                        oldName: itemLists[index].name,
                      ),
                    );
                  },
                  onToggleDelete: () {
                    showDialog(
                      context: context,
                      builder: (context) => DeleteListDialog(
                        name: itemLists[index].name,
                        onConfirm: () => DeleteList(index),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AddListDialog(onAdd: AddList),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
