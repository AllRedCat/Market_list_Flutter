import 'package:flutter/material.dart';
import 'package:market_list/pages/market_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de compras',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.lightBlueAccent),
        useMaterial3: true,
      ),
      home: const ListPage(title: 'Flutter Demo Home Page'),
    );
  }
}
