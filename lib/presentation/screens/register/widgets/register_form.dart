import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:proyectofinal/domain/providers/user_provider.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _handleRegister(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    if (_formKey.currentState!.validate()) {
      try {
        await userProvider.register(
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Usuario registrado con éxito")),
        );
        context.go('/login');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error al registrar: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Nombre"),
              validator: (value) => value!.isEmpty ? "El nombre es obligatorio" : null,
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Correo Electrónico"),
              validator: (value) => value!.isEmpty ? "El correo es obligatorio" : null,
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: "Contraseña"),
              obscureText: true,
              validator: (value) => value!.isEmpty ? "La contraseña es obligatoria" : null,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _handleRegister(context),
              child: Text("Registrar"),
            ),
          ],
        ),
      ),
    );
  }
}
