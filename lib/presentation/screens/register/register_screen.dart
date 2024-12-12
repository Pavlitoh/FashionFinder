import 'package:flutter/material.dart';
import 'widgets/register_form.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registrar Usuario"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), // Regresa a la pantalla anterior
        ),
      ),
      body: RegisterForm(),
    );
  }
}
