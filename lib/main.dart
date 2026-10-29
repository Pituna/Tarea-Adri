import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'portfolio_page.dart';
import 'welcome_page.dart';

void main() {
  runApp(const MyPortfolioApp());
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const WelcomePage(),
    ),
    GoRoute(
      path: '/hobbies',
      builder: (context, state) => const PortfolioPage(
        initialSection: PortfolioSection.hobbies,
      ),
    ),
    GoRoute(
      path: '/repositories',
      builder: (context, state) => const PortfolioPage(
        initialSection: PortfolioSection.repositories,
      ),
    ),
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
