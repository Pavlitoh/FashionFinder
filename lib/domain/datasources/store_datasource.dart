import 'package:dio/dio.dart';
import 'package:proyectofinal/entities/store.dart';

class StoreDatasource {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "http://fashionfinder.ddns.net:3000/api",
  ));

  Future<List<Store>> getStores() async {
    try {
      final response = await _dio.get("/stores");
      return (response.data as List).map((store) => Store.fromJson(store)).toList();
    } catch (e) {
      throw Exception("Error al obtener las tiendas: $e");
    }
  }

  Future<Store> getStoreById(String id) async {
    try {
      final response = await _dio.get("/stores/$id");
      return Store.fromJson(response.data);
    } catch (e) {
      throw Exception("Error al obtener el detalle de la tienda: $e");
    }
  }

  Future<void> createStore(Store store) async {
    try {
      await _dio.post("/stores", data: store.toJson());
    } catch (e) {
      throw Exception("Error al crear la tienda: $e");
    }
  }
}
