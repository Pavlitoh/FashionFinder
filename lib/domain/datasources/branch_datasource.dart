import 'package:dio/dio.dart';
import 'package:proyectofinal/entities/branch.dart';

class BranchDatasource {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "http://fashionfinder.ddns.net:3000/api",
  ));

  Future<List<Branch>> getBranches() async {
    try {
      final response = await _dio.get("/branches");
      return (response.data as List)
          .map((branch) => Branch.fromJson(branch))
          .toList();
    } catch (e) {
      throw Exception("Error al obtener las sucursales: $e");
    }
  }

  Future<Branch> getBranchById(String id) async {
    try {
      final response = await _dio.get("/branches/$id");
      return Branch.fromJson(response.data);
    } catch (e) {
      throw Exception("Error al obtener el detalle de la sucursal: $e");
    }
  }

  Future<void> createBranch(Branch branch) async {
    try {
      await _dio.post("/branches", data: branch.toJson());
    } catch (e) {
      throw Exception("Error al crear la sucursal: $e");
    }
  }
}
