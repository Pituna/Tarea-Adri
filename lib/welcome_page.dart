
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'services/auth_service.dart';
import 'services/storage_service.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  Future<void> _comenzar(BuildContext context) async {
    final storageService = StorageService();
    final authService = AuthService();

    final token = await storageService.getToken();

    if (token == null || token.isEmpty) {
      context.go('/login');
      return;
    }

    final result = await authService.getWelcomeMessage(token);

    if (!context.mounted) return;

    if (result['success'] == true) {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Bienvenido'),
          content: Text(result['message'] ?? 'Bienvenido a Los Manoletes'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Continuar'),
            ),
          ],
        ),
      );

      if (context.mounted) {
        context.go('/hobbies');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message'] ?? 'Error al conectar con la API'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF061C2D),
              Color(0xFF075080),
              Color(0xFF031625),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 18,
            ),
            child: Column(
              children: [
                const Spacer(flex: 2),
                const Icon(
                  Icons.fitness_center,
                  size: 82,
                  color: Colors.white,
                ),
                const SizedBox(height: 12),
                const FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'LOS MANOLETES',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'GIMNASIO · TENERIFE',
                  style: TextStyle(
                    color: Color(0xFF66D2FF),
                    fontSize: 15,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(flex: 3),
                const Text(
                  'Bienvenido a\nLos Manoletes',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Tu objetivo, nuestro compromiso',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                const Spacer(flex: 1),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () => _comenzar(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0788E8),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 3,
                    ),
                    child: const Text(
                      'Comenzar',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
