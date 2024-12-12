import 'package:flutter/material.dart';
import 'package:proyectofinal/domain/datasources/producto_datasource.dart';
import 'package:proyectofinal/entities/producto.dart';

class ProductProvider extends ChangeNotifier {
  final ProductDatasource _productDatasource;

  ProductProvider(this._productDatasource);

  List<Product> products = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> fetchProducts() async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      products = await _productDatasource.getProducts();
    } catch (e) {
      errorMessage = "Error al cargar los productos: $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchProductsByStore(String storeId) async {
  try {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    products = await _productDatasource.getProductsByStore(storeId);
  } catch (e) {
    errorMessage = "Error al cargar los productos de la tienda: $e";
  } finally {
    isLoading = false;
    notifyListeners();
  }
}

}
