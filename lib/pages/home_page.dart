import 'package:flutter/material.dart';
import 'package:market_list/pages/login_page.dart';
import 'package:market_list/pages/resgiter_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0, // remove o espaço da toolbar
          automaticallyImplyLeading: false,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Login'),
              Tab(text: 'Registrar'),
            ],
          ),
        ),
        body: TabBarView(children: <Widget>[LoginPage(), RegisterPage()]),
      ),
    );
  }
}
