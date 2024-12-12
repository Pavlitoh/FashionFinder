import 'package:flutter/material.dart';
import 'package:proyectofinal/domain/datasources/category_datasource.dart';
import 'package:proyectofinal/entities/category.dart';

class CategoryProvider extends ChangeNotifier {
  final CategoryDatasource _categoryDatasource;

  CategoryProvider(this._categoryDatasource);

  List<Category> categories = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> fetchCategories() async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      categories = await _categoryDatasource.getCategories();
    } catch (e) {
      errorMessage = "Error al cargar las categorías: $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
