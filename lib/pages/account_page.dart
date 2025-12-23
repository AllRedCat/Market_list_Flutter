import 'package:flutter/material.dart';
import 'package:market_list/layout/auth_layout.dart';
import 'package:market_list/services/auth_service.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  Future<void> _handleLogout(context) async {
    await authService.value.signOut();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AuthLayout(pageIfNotConnected: null),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Conta')),
      body: Column(
        children: [
          ListTile(leading: Icon(Icons.person), title: Text('Perfil')),
          ListTile(leading: Icon(Icons.settings), title: Text('Configurações')),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            textColor: Colors.red,
            title: Text('Sair'),
            onTap: () => _handleLogout(context),
          ),
        ],
      ),
    );
  }
}
