
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'login_screen.dart';
import 'register_screen.dart';
import 'welcome_page.dart';
import 'portfolio_page.dart';

import 'services/auth_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Comprobar si existe una sesión guardada
  authController.checkSession();

  runApp(const MyPortfolioApp());
}

// Configuración de las rutas
final GoRouter _router = GoRouter(

  initialLocation: '/loading',

  // Escuchar los cambios de autenticación
  refreshListenable: authController,

  // Controlar el acceso a las pantallas
  redirect: (context, state) {

    final location = state.matchedLocation;

    // Mientras comprobamos el token
    if (authController.isLoading) {
      if (location != '/loading') {
        return '/loading';
      }

      return null;
    }

    // Si no ha iniciado sesión
    if (!authController.isAuthenticated) {

      if (location == '/login' ||
          location == '/register') {
        return null;
      }

      return '/login';
    }

    // Si ya ha iniciado sesión
    // no puede volver al login ni al registro
    if (location == '/login' ||
        location == '/register' ||
        location == '/loading' ||
        location == '/') {
      return '/welcome';
    }

    return null;
  },

  routes: [

    // Pantalla de carga
    GoRoute(
      path: '/loading',
      builder: (context, state) => const Scaffold(
        backgroundColor: Color(0xFF061C2D),
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
    ),

    // Login
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),

    // Registro
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),

    // Bienvenida
    GoRoute(
      path: '/welcome',
      builder: (context, state) => const WelcomePage(),
    ),

    // Aficiones
    GoRoute(
      path: '/hobbies',
      builder: (context, state) => const PortfolioPage(
        initialSection: PortfolioSection.hobbies,
      ),
    ),

    // Repositorios
    GoRoute(
      path: '/repositories',
      builder: (context, state) => const PortfolioPage(
        initialSection: PortfolioSection.repositories,
      ),
    ),

    // CRUD
    GoRoute(
      path: '/crud',
      builder: (context, state) => const PortfolioPage(
        initialSection: PortfolioSection.crud,
      ),
    ),
  ],
);

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
