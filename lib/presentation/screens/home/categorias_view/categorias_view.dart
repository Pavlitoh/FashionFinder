import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectofinal/domain/providers/category_provider.dart';
import 'package:proyectofinal/presentation/shared/fondo.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CategoryProvider>(context, listen: false).fetchCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Catálogo Móvil"),
        actions: [
          IconButton(
            icon: const Icon(Icons.store),
            onPressed: () {
              context.go('/shops');
            },
          ),
        ],
      ),
      body: Fondo(
        child: Column(
          children: [
            Expanded(
              child: Consumer<CategoryProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (provider.errorMessage != null) {
                    return Center(
                      child: Text(
                        provider.errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  if (provider.categories.isEmpty) {
                    return const Center(child: Text("No hay categorías disponibles."));
                  }

                  return ListView.builder(
                    itemCount: provider.categories.length,
                    itemBuilder: (context, index) {
                      final category = provider.categories[index];
                      return Card(
                        elevation: 3,
                        margin: const EdgeInsets.all(10.0),
                        child: ListTile(
                          leading: category.image != null
                              ? Image.network(
                                  category.image!,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(Icons.broken_image);
                                  },
                                )
                              : const Icon(Icons.image),
                          title: Text(
                            category.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(category.description),
                          onTap: () {
                            context.go('/categories/${category.id}/map');
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
