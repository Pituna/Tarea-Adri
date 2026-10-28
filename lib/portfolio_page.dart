import 'package:flutter/material.dart';

import 'header_section.dart';
import 'hobbies_section.dart';
import 'repositories_section.dart';
import 'bottom_navigation.dart';

enum PortfolioSection {
  hobbies,
  repositories,
}

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  PortfolioSection selectedSection = PortfolioSection.hobbies;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const HeaderSection(),

            Expanded(
              child: selectedSection == PortfolioSection.hobbies
                  ? const HobbiesSection()
                  : const RepositoriesSection(),
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