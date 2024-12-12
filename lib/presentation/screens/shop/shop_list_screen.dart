import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:proyectofinal/domain/providers/store_provider.dart';
import 'package:proyectofinal/domain/providers/user_provider.dart';

class ShopListScreen extends StatefulWidget {
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

    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Tiendas"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              userProvider.logout();
              context.go('/login');
            },
          ),
        ],
      ),
      body: Consumer<StoreProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (provider.errorMessage != null) {
            return Center(
              child: Text(
                provider.errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
            );
          }

          if (provider.stores.isEmpty) {
            return Center(child: Text("No se encontraron tiendas."));
          }

          return Column(
            children: [
              if (userProvider.loggedInUser?.role == 'admin')
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => context.go('/shop/create'),
                    child: Text("Crear Tienda"),
                  ),
                ),
              Expanded(
                child: ListView.builder(
                  itemCount: provider.stores.length,
                  itemBuilder: (context, index) {
                    final store = provider.stores[index];
                    return Card(
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: ListTile(
                        title: Text(store.name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(store.description),
                              TextButton(
                                onPressed: () {
                                  context.go('/productos/${store.id}'); // Navegamos a la lista de productos con el storeId
                                },
                                child: Text("Ver Productos"),
                              ),

                          ],
                        ),
                        onTap: () {
                          context.go('/shop/details/${store.id}');
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
