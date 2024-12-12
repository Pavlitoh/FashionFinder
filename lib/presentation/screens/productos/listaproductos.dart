import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:proyectofinal/domain/providers/producto_provider.dart';
import 'package:proyectofinal/domain/providers/user_provider.dart';

class ProductListScreen extends StatefulWidget {
  final String storeId;

  const ProductListScreen({required this.storeId});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ProductProvider>(context, listen: false).fetchProductsByStore(widget.storeId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Productos"),
      ),
      body: Column(
        children: [
          // Botón para volver a tiendas (siempre visible)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                context.go('/shops'); // Navega a la lista de tiendas
              },
              child: const Text("Volver a Tiendas"),
            ),
          ),
          Expanded(
            child: Consumer<ProductProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (provider.errorMessage != null) {
                  return Center(
                    child: Text(provider.errorMessage!),
                  );
                }

                if (provider.products.isEmpty) {
                  return const Center(child: Text("No hay productos disponibles."));
                }

                return Column(
                  children: [
                    if (userProvider.loggedInUser?.role == 'admin')
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            context.go('/productos/${widget.storeId}/crear');
                          },
                          child: const Text("Agregar Producto"),
                        ),
                      ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: provider.products.length,
                        itemBuilder: (context, index) {
                          final product = provider.products[index];
                          return ListTile(
                            leading: product.image != null
                                ? Image.network(
                                    product.image!,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(Icons.broken_image);
                                    },
                                  )
                                : const Icon(Icons.image),
                            title: Text(product.name),
                            subtitle: Text("\$${product.price.toStringAsFixed(2)}"),
                            onTap: () {
                              context.go('/productos/detalles/${product.id}');
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
