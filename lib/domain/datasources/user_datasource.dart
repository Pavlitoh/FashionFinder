import 'package:dio/dio.dart';
import 'package:proyectofinal/entities/user.dart';

class UserDatasource {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "http://fashionfinder.ddns.net:3000/api",
  ));

  Future<User> login(String email, String password) async {
    try {
      final response = await _dio.post(
        "/users/login",
        data: {
          "email": email,
          "password": password,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        return User.fromJson(response.data);
      } else {
        throw Exception("Credenciales inválidas");
      }
    } catch (e) {
      throw Exception("Error al iniciar sesión: ${e.toString()}");
    }
  }

  Future<void> register(String name, String email, String password) async {
    try {
      await _dio.post(
        "/users/register",
        data: {
          "name": name,
          "email": email,
          "password": password,
        },
      );
    } catch (e) {
      throw Exception("Error al registrar usuario: ${e.toString()}");
    }
  }
}
