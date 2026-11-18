
import 'package:flutter/material.dart';

import 'auth_service.dart';
import 'storage_service.dart';

class AuthController extends ChangeNotifier {

  final AuthService authService = AuthService();
  final StorageService storageService = StorageService();

  bool isLoading = true;
  bool isAuthenticated = false;

  // Comprobar sesión al iniciar la aplicación
  Future<void> checkSession() async {

    final token = await storageService.getToken();

    if (token == null || token.isEmpty) {
      isAuthenticated = false;
    } else {

      final result = await authService.checkToken(token);

      if (result['success'] == true) {
        isAuthenticated = true;
      } else {

        // Si el servidor confirma que el token
        // no es válido, lo eliminamos.
        if (result['statusCode'] == 401 ||
            result['statusCode'] == 403) {
          await storageService.deleteToken();
        }

        isAuthenticated = false;
      }
    }

    isLoading = false;
    notifyListeners();
  }

  // Actualizar el estado después del login
  void login() {
    isAuthenticated = true;
    notifyListeners();
  }

  // Cerrar sesión
  Future<void> logout() async {
    await storageService.deleteToken();

    isAuthenticated = false;
    notifyListeners();
  }
}

// Instancia compartida por toda la aplicación
final AuthController authController = AuthController();
