import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proyectofinal/domain/datasources/store_datasource.dart';
import 'package:proyectofinal/entities/store.dart';
class StoreDetailScreen extends StatefulWidget {
  final String storeId;

  const StoreDetailScreen({required this.storeId});

  @override
  _StoreDetailScreenState createState() => _StoreDetailScreenState();
}

class _StoreDetailScreenState extends State<StoreDetailScreen> {
  late Future<Store> _storeFuture;

  @override
  void initState() {
    super.initState();
    final datasource = StoreDatasource();
    _storeFuture = datasource.getStoreById(widget.storeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalle de la Tienda"),
        actions: [
          // Botón para ir al Login
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              context.go('/shops'); 
            },
          ),
        ],
      ),
      body: FutureBuilder<Store>(
        future: _storeFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error al cargar el detalle de la tienda:\n${snapshot.error}",
                style: TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            );
          }

          final store = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (store.image != null && store.image!.isNotEmpty)
                  Image.network(
                    store.image!,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200,
                        color: Colors.grey,
                        child: Center(child: Text("Error al cargar la imagen")),
                      );
                    },
                  ),
                SizedBox(height: 16),
                Text("Nombre:", style: TextStyle(fontWeight: FontWeight.bold)),
                Text(store.name),
                SizedBox(height: 16),
                Text("Descripción:", style: TextStyle(fontWeight: FontWeight.bold)),
                Text(store.description),
                SizedBox(height: 16),
                Text("Categoría ID:", style: TextStyle(fontWeight: FontWeight.bold)),
                Text(store.categoryId),
                SizedBox(height: 16),
                Text("Dirección:", style: TextStyle(fontWeight: FontWeight.bold)),
                Text(store.mainAddress),
                SizedBox(height: 16),
                Text("Teléfono:", style: TextStyle(fontWeight: FontWeight.bold)),
                Text(store.mainPhone),
                if (store.website != null) ...[
                  SizedBox(height: 16),
                  Text("Sitio Web:", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(store.website!),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
