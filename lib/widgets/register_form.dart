import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  final Future<void> Function(
    String name,
    String email,
    String password,
    String confirmPassword,
  )
  onSubmit;
  const RegisterForm({super.key, required this.onSubmit});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _name,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: 'Nome',
              hintText: 'Digite seu nome',
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 4.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                gapPadding: 8.00,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email',
              hintText: 'example@email.com',
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 4.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                gapPadding: 8.00,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _passwordController,
            obscureText: _obscureText,
            decoration: const InputDecoration(
              labelText: 'Senha',
              hintText: 'Digite sua senha',
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 4.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                gapPadding: 8.00,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _confirmPasswordController,
            obscureText: _obscureText,
            decoration: const InputDecoration(
              labelText: 'Confirme a Senha',
              hintText: 'Digite sua senha novamente',
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 4.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                gapPadding: 8.00,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.transparent),
              elevation: WidgetStatePropertyAll(0),
              foregroundColor: WidgetStatePropertyAll(Colors.grey),
              textStyle: WidgetStatePropertyAll(
                TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                SizedBox(width: 12),
                Text(
                  'Mostrar senha',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                widget.onSubmit(
                  _name.text,
                  _emailController.text,
                  _passwordController.text,
                  _confirmPasswordController.text,
                );
              }
            },
            style: ButtonStyle(
              minimumSize: WidgetStatePropertyAll(Size.fromHeight(48.0)),
              backgroundColor: WidgetStatePropertyAll(Color(0xFF3584E4)),
              foregroundColor: WidgetStatePropertyAll(Colors.white),
              textStyle: WidgetStatePropertyAll(
                TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
            child: Text('Registrar'),
          ),
        ],
      ),
    );
  }
}
