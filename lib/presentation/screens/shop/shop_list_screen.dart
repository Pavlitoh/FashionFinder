import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:proyectofinal/domain/providers/store_provider.dart';
import 'package:proyectofinal/domain/providers/user_provider.dart';

class ShopListScreen extends StatefulWidget {
  final String? categoryId;

  const ShopListScreen({this.categoryId, Key? key}) : super(key: key);

  @override
  _ShopListScreenState createState() => _ShopListScreenState();
}

class _ShopListScreenState extends State<ShopListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<StoreProvider>(context, listen: false).fetchStores();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final storeProvider = Provider.of<StoreProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.categoryId == null ? "Lista de Tiendas" : "Tiendas Filtradas",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go(widget.categoryId == null ? '/home' : '/categories/${widget.categoryId}/map');
          },
        ),
        backgroundColor: Colors.pinkAccent.shade100,
      ),
      body: Consumer<StoreProvider>(
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

          final stores = widget.categoryId == null
              ? provider.stores
              : provider.filterStoresByCategory(widget.categoryId!);

          if (stores.isEmpty) {
            return const Center(child: Text("No se encontraron tiendas."));
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: stores.length,
                    itemBuilder: (context, index) {
                      final store = stores[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 4,
                        child: InkWell(
                          onTap: () {
                            context.go('/shop/details/${store.id}');
                          },
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                ),
                                child: Image.network(
                                  store.image ?? 'https://via.placeholder.com/150',
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        store.name,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.purple,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        store.description,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: TextButton(
                                          onPressed: () {
                                            context.go('/productos/${store.id}');
                                          },
                                          child: const Text(
                                            "Ver Productos",
                                            style: TextStyle(color: Colors.pinkAccent),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: userProvider.loggedInUser?.role == 'admin'
          ? FloatingActionButton(
              onPressed: () => context.go('/shop/create'),
              backgroundColor: Colors.purpleAccent,
              child: const Icon(Icons.add, color: Colors.white),
              tooltip: "Crear Tienda",
            )
          : null,
    );
  }
}
