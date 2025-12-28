import 'package:flutter/material.dart';
import 'package:market_list/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:market_list/pages/loding_page.dart';
import 'package:market_list/pages/lists_page.dart';
import 'package:market_list/pages/home_page.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({super.key, required this.pageIfNotConnected});

  final Widget? pageIfNotConnected;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AuthService>(
      valueListenable: authService,
      builder: (context, svc, child) {
        return ValueListenableBuilder<bool>(
          valueListenable: svc.isLoading,
          builder: (context, isLoading, child) {
            if (isLoading) return const LodingPage();
            return StreamBuilder<User?>(
              stream: svc.authStateChanges,
              builder: (context, snapshot) {
                Widget widget;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  widget = const LodingPage();
                } else if (snapshot.hasData) {
                  widget = const ListsPage();
                } else {
                  widget = pageIfNotConnected ?? const HomePage();
                }
                return widget;
              },
            );
          },
        );
      },
    );
  }
}
