import 'package:flutter/material.dart';
import 'package:market_list/services/auth_service.dart';
import 'package:market_list/pages/loding_page.dart';
import 'package:market_list/pages/lists_page.dart';
import 'package:market_list/pages/home_page.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({super.key, required this.pageIfNotConnected});

  final Widget? pageIfNotConnected;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: authService,
      builder: (context, authService, child) {
        return StreamBuilder(
          stream: authService.authStateChanges,
          builder: (context, snapshot) {
            Widget widget;
            if (snapshot.connectionState == ConnectionState.waiting) {
              widget = LodingPage();
            } else if (snapshot.hasData) {
              widget = ListsPage();
            } else {
              widget = pageIfNotConnected ?? HomePage();
            }
            return widget;
          },
        );
      },
    );
  }
}
