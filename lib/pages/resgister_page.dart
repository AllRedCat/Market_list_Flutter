import 'package:flutter/material.dart';
import 'package:market_list/widgets/register_form.dart';
import 'package:market_list/pages/lists_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Future<void> _handleRegister(
    BuildContext context,
    String name,
    String email,
    String password,
    String confirmPassword,
  ) async {
    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos.')),
      );
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Registro ainda em processo')));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image(image: AssetImage('assets/logo.png'), height: 60.0),
          const Text(
            'Registri-se!',
            style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          RegisterForm(
            onSubmit: (name, email, password, confirmPassword) =>
                _handleRegister(
                  context,
                  name,
                  email,
                  password,
                  confirmPassword,
                ),
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
    );
  }
}
