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
        backgroundColor: Colors.pinkAccent.shade100,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            context.go('/shops');
          },
        ),
        title: const Text(
          "Detalle de la Tienda",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<Store>(
        future: _storeFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error al cargar el detalle de la tienda:\n${snapshot.error}",
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            );
          }

          final store = snapshot.data!;
          return Stack(
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
              SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Imagen destacada
                    if (store.image != null && store.image!.isNotEmpty)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          store.image!,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 200,
                              color: Colors.grey,
                              child: const Center(child: Text("Error al cargar la imagen")),
                            );
                          },
                        ),
                      ),
                    const SizedBox(height: 16),

                    // Detalles de la tienda
                    Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              store.name,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.purple,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "${store.description}",
                              style: const TextStyle(fontSize: 16),
                            ),
                            const Divider(height: 20, color: Colors.grey),
                            Row(
                              children: [
                                const Icon(Icons.location_on, color: Colors.pinkAccent),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    store.mainAddress,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                const Icon(Icons.phone, color: Colors.pinkAccent),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    store.mainPhone,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            if (store.website != null && store.website!.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: Row(
                                  children: [
                                    const Icon(Icons.web, color: Colors.pinkAccent),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          // Abre el sitio web en el navegador
                                          context.go(store.website!);
                                        },
                                        child: Text(
                                          store.website!,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.blue,
                                            decoration: TextDecoration.underline,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
