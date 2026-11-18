
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {

  // URL principal de la API
  static const String baseUrl =
      'https://my-users-api.onrender.com/users';

  // REGISTRO DE USUARIO
  Future<Map<String, dynamic>> registerUser(
    String fullName,
    String email,
    String password,
  ) async {

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'fullName': fullName,
          'email': email,
          'pwd': password,
        }),
      );

      final data = jsonDecode(response.body);

      return {
        'success': response.statusCode == 201,
        'message': data['message'] ?? 'Respuesta desconocida',
      };

    } catch (e) {
      return {
        'success': false,
        'message': 'Error de conexión con el servidor.',
      };
    }
  }

  // INICIO DE SESIÓN
  Future<Map<String, dynamic>> loginUser(
    String email,
    String password,
  ) async {

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'pwd': password,
        }),
      );

      final data = jsonDecode(response.body);

      return {
        'success': response.statusCode == 200,
        'message': data['message'] ?? 'Respuesta desconocida',
        'token': data['token'],
      };

    } catch (e) {
      return {
        'success': false,
        'message': 'Error de conexión con el servidor.',
      };
    }
  }

  // COMPROBAR SI EL TOKEN ES VÁLIDO
  
  // COMPROBAR SI EL TOKEN ES VÁLIDO
  Future<Map<String, dynamic>> checkToken(String token) async {

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/check-token'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      final data = jsonDecode(response.body);

      return {
        'success': response.statusCode == 200,
        'message': data['message'] ?? 'Respuesta desconocida',
        'statusCode': response.statusCode,
      };

    } catch (e) {
      return {
        'success': false,
        'message': 'Error al comprobar el token.',
        'statusCode': null,
      };
    }
  }


  // OBTENER MENSAJE DE BIENVENIDA
  Future<Map<String, dynamic>> getWelcomeMessage(String token) async {

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/welcome'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      final data = jsonDecode(response.body);

      return {
        'success': response.statusCode == 200,
        'message': data['message'] ?? 'Respuesta desconocida',
      };

    } catch (e) {
      return {
        'success': false,
        'message': 'Error al obtener el mensaje de bienvenida.',
      };
    }
  }
}
