import 'package:flutter/material.dart';
import 'package:proyectofinal/domain/datasources/store_datasource.dart';
import 'package:proyectofinal/entities/store.dart';

class StoreProvider extends ChangeNotifier {
  final StoreDatasource _datasource;

  StoreProvider(this._datasource);

  List<Store> stores = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> fetchStores() async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      stores = await _datasource.getStores();
    } catch (e) {
      errorMessage = "Error al cargar las tiendas: $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  List<Store> filterStoresByCategory(String categoryId) {
    return stores.where((store) => store.categoryId == categoryId).toList();
  }
}
