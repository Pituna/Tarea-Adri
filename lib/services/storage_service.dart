
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {

  // Crear almacenamiento seguro
  static const storage = FlutterSecureStorage();

  // Guardar el token
  Future<void> saveToken(String token) async {
    await storage.write(
      key: 'jwt_token',
      value: token,
    );
  }

  // Obtener el token guardado
  Future<String?> getToken() async {
    return await storage.read(
      key: 'jwt_token',
    );
  }

  // Eliminar el token
  Future<void> deleteToken() async {
    await storage.delete(
      key: 'jwt_token',
    );
  }
}
