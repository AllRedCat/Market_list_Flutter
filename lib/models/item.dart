import 'package:flutter/material.dart';

class Item {
  String name;
  bool checked;

  Item({required this.name, this.checked = false});

  Map<String, dynamic> toJson() => {'name': name, 'checked': checked};

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    name: json['name'] as String,
    checked: json['checked'] as bool? ?? false,
  );
}
