import 'package:flutter/material.dart';
import 'package:market_list/widgets/login_form.dart';
import 'package:market_list/pages/home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  Future<void> _handdleLogin(
    BuildContext context,
    String email,
    String password,
  ) async {
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos.')),
      );
      return;
    }

    if (email == "test@email.com" && password == "123456") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email ou senha incorretos.')),
      );
    }
    // Implement your login logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(16.0),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image(image: AssetImage('assets/logo.png'), height: 120.0),
            const Text(
              'Bem vindo!',
              style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            LoginForm(
              onSubmit: (email, password) =>
                  _handdleLogin(context, email, password),
            ),
            Divider(height: 38.0),
            ElevatedButton(
              onPressed: null,
              style: ButtonStyle(
                minimumSize: WidgetStatePropertyAll(Size.fromHeight(48.0)),
                backgroundColor: WidgetStatePropertyAll(
                  Color.fromARGB(255, 212, 212, 212),
                ),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('assets/google_logo.png'),
                    height: 24.0,
                    width: 24.0,
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Entrar com conta Google',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
