import 'package:flutter/material.dart';
import 'package:proyectofinal/domain/datasources/user_datasource.dart';
import 'package:proyectofinal/entities/user.dart';

class UserProvider extends ChangeNotifier {
  final UserDatasource _datasource = UserDatasource();
  User? loggedInUser;
  String? errorMessage;
  bool isLoading = false;

  Future<void> login(String email, String password) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      loggedInUser = await _datasource.login(email, password);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      await _datasource.register(name, email, password);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void logout() {
    loggedInUser = null;
    notifyListeners();
  }
}
