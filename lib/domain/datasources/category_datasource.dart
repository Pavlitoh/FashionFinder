import 'package:dio/dio.dart';
import 'package:proyectofinal/entities/category.dart';

class CategoryDatasource {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "http://fashionfinder.ddns.net:3000/api",
  ));

  Future<List<Category>> getCategories() async {
    try {
      final response = await _dio.get("/categories");
      return (response.data as List)
          .map((category) => Category.fromJson(category))
          .toList();
    } catch (e) {
      throw Exception("Error al obtener las categorías: $e");
    }
  }

  Future<Category> getCategoryById(String id) async {
    try {
      final response = await _dio.get("/categories/$id");
      return Category.fromJson(response.data);
    } catch (e) {
      throw Exception("Error al obtener el detalle de la categoría: $e");
    }
  }

  Future<void> createCategory(Category category) async {
    try {
      await _dio.post("/categories", data: category.toJson());
    } catch (e) {
      throw Exception("Error al crear la categoría: $e");
    }
  }
}
