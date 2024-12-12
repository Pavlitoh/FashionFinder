import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proyectofinal/domain/datasources/producto_datasource.dart';
import 'package:proyectofinal/entities/producto.dart';
import 'package:proyectofinal/presentation/shared/fondo.dart'; // Asegúrate de importar GoRouter

class DetalleProductoPage extends StatefulWidget {
  final String productId;

  const DetalleProductoPage({Key? key, required this.productId}) : super(key: key);

  @override
  _DetalleProductoPageState createState() => _DetalleProductoPageState();
}

class _DetalleProductoPageState extends State<DetalleProductoPage> {
  late Future<Product> _productFuture;

  @override
  void initState() {
    super.initState();
    final datasource = ProductDatasource();
    _productFuture = datasource.getProductById(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalle del Producto"),
      ),
      body: Fondo(
        child: FutureBuilder<Product>(
          future: _productFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Error al cargar el detalle del producto:\n${snapshot.error}",
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              );
            }

            final product = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (product.image != null && product.image!.isNotEmpty)
                    Image.network(
                      product.image!,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200,
                          color: Colors.grey,
                          child: const Center(child: Text("Error al cargar la imagen")),
                        );
                      },
                    ),
                  const SizedBox(height: 16),
                  Text(
                    "Nombre: ${product.name}",
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text("Descripción: ${product.description}"),
                  const SizedBox(height: 16),
                  Text("Precio: \$${product.price.toStringAsFixed(2)}"),
                  const SizedBox(height: 16),
                  Text("Tienda ID: ${product.store_id}"),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.go('/productos/${product.store_id}');
                    },
                    child: const Text("Volver a la Lista de Productos"),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
