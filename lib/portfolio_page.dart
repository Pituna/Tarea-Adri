
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'header_section.dart';
import 'hobbies_section.dart';
import 'repositories_section.dart';
import 'bottom_navigation.dart';
import 'crud_screen.dart';
import 'services/auth_controller.dart';

enum PortfolioSection {
  hobbies,
  repositories,
  crud,
}

class PortfolioPage extends StatefulWidget {
  final PortfolioSection initialSection;

  const PortfolioPage({
    super.key,
    this.initialSection = PortfolioSection.hobbies,
  });

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  late PortfolioSection selectedSection = widget.initialSection;

  Future<void> _cerrarSesion() async {
    await authController.logout();

    if (!mounted) return;

    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi portfolio'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Navegación del portfolio',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.interests),
              title: const Text('Aficiones'),
              selected: selectedSection == PortfolioSection.hobbies,
              onTap: () {
                Navigator.pop(context);
                context.go('/hobbies');
              },
            ),
            ListTile(
              leading: const Icon(Icons.folder),
              title: const Text('Repo'),
              selected: selectedSection == PortfolioSection.repositories,
              onTap: () {
                Navigator.pop(context);
                context.go('/repositories');
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit_note),
              title: const Text('CRUD de elementos'),
              selected: selectedSection == PortfolioSection.crud,
              onTap: () {
                Navigator.pop(context);
                context.go('/crud');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                'Cerrar sesión',
                style: TextStyle(color: Colors.red),
              ),
              onTap: _cerrarSesion,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const HeaderSection(),
            Expanded(
              child: selectedSection == PortfolioSection.hobbies
                  ? const HobbiesSection()
                  : selectedSection == PortfolioSection.repositories
                      ? const RepositoriesSection()
                      : const CrudScreen(),
            ),
            BottomNavigation(
              selectedSection: selectedSection,
              onSectionSelected: (section) {
                setState(() {
                  selectedSection = section;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
