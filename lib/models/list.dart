import 'package:market_list/models/item.dart';

class ItemsList {
  String? id;
  String name;
  List<Item> items;

  ItemsList({this.id, required this.name, List<Item>? items}) : items = items ?? [];

  Map<String, dynamic> toJson() => {
    'name': name,
    'items': items.map((item) => item.toJson()).toList(),
  };

  factory ItemsList.fromJson(Map<String, dynamic> json, [String? id]) => ItemsList(
    id: id ?? json['id'] as String?,
    name: json['name'] as String,
    items: (json['items'] as List<dynamic>? ?? [])
        .map((i) => Item.fromJson(i as Map<String, dynamic>))
        .toList(),
  );
}
