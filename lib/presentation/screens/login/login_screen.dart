import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Permite que la pantalla se adapte al teclado
      body: Stack(
        children: [
          // Fondo degradado
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.pinkAccent.shade100,
                  Colors.purpleAccent.shade100,
                ],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // Encabezado con ícono y texto
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => GoRouter.of(context).go('/'),
                      ),
                      Text(
                        "Iniciar Sesión",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: LoginForm(), // Formulario
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
