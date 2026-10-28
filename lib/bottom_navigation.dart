import 'package:flutter/material.dart';
import 'portfolio_page.dart';

class BottomNavigation extends StatelessWidget {
  final PortfolioSection selectedSection;
  final ValueChanged<PortfolioSection> onSectionSelected;

  const BottomNavigation({
    super.key,
    required this.selectedSection,
    required this.onSectionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.yellow,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ClipOval(
            child: GestureDetector(
              onTap: () {
                onSectionSelected(PortfolioSection.hobbies);
              },
              child: Container(
                width: 150,
                height: 60,
                color: selectedSection == PortfolioSection.hobbies
                    ? Colors.red
                    : Colors.redAccent,
                alignment: Alignment.center,
                child: const FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Aficiones',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ),
          ),

          GestureDetector(
            onTap: () {
              onSectionSelected(PortfolioSection.repositories);
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: selectedSection == PortfolioSection.repositories
                    ? Colors.red
                    : Colors.redAccent,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Text(
                'Mi super repositorio',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}