import 'package:flutter/material.dart';
import 'categorias_view/categorias_view.dart';
import '../../widgets/shared/bottom_navbar.dart';

class HomeScreen extends StatelessWidget {
  final int viewIndex;

  const HomeScreen({super.key, required this.viewIndex});

  List<Widget> get viewRoutes => [
        const HomeView(), // Vista de categorías
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: viewIndex,
        children: viewRoutes,
      ),
      bottomNavigationBar: BottomNavbar(index: viewIndex),
    );
  }
}
