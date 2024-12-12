import 'package:dio/dio.dart';
import 'package:proyectofinal/entities/producto.dart';

class ProductDatasource {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "http://fashionfinder.ddns.net:3000/api",
  ));

  Future<List<Product>> getProducts() async {
    try {
      final response = await _dio.get("/products");
      return (response.data as List)
          .map((product) => Product.fromJson(product))
          .toList();
    } catch (e) {
      throw Exception("Error al obtener los productos: $e");
    }
  }

  Future<Product> getProductById(String id) async {
    try {
      final response = await _dio.get("/products/$id");
      return Product.fromJson(response.data);
    } catch (e) {
      throw Exception("Error al obtener el detalle del producto: $e");
    }
  }

  Future<void> createProduct(Product product) async {
    try {
      await _dio.post("/products", data: product.toJson());
    } catch (e) {
      throw Exception("Error al crear el producto: $e");
    }
  }

  Future<List<Product>> getProductsByStore(String storeId) async {
  try {
    final response = await _dio.get("/products", queryParameters: {
      "store": storeId,
    });
    return (response.data as List)
        .map((product) => Product.fromJson(product))
        .toList();
  } catch (e) {
    throw Exception("Error al obtener los productos de la tienda: $e");
  }
}

}
