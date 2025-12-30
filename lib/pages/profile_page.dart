import 'package:flutter/material.dart';
import 'package:market_list/services/auth_service.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = authService.value.currentUser;

    print(currentUser);

    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: currentUser != null
          ? Column(
              children: [
                Column(),
                const SizedBox(height: 16.00),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    currentUser.photoURL ??
                        'https://www.gravatar.com/avatar/placeholder',
                  ),
                ),
                const SizedBox(height: 16.0),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text(currentUser.displayName ?? 'Sem nome'),
                ),
                ListTile(
                  leading: Icon(Icons.email),
                  title: Text(currentUser.email ?? 'Sem email'),
                ),
                ListTile(
                  leading: Icon(Icons.delete, color: Colors.red),
                  textColor: Colors.red,
                  title: Text('Excluir conta'),
                ),
              ],
            )
          : const Center(child: Text('Usuário não autenticado')),
    );
  }
}
