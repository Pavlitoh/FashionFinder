import 'package:flutter/material.dart';
import 'package:proyectofinal/domain/datasources/branch_datasource.dart';
import 'package:proyectofinal/entities/branch.dart';

class BranchProvider extends ChangeNotifier {
  final BranchDatasource _branchDatasource = BranchDatasource();
  List<Branch> branches = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> getBranches() async {
    try {
      isLoading = true;
      notifyListeners();

      branches = await _branchDatasource.getBranches();
    } catch (e) {
      errorMessage = "Error al cargar las sucursales: $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
