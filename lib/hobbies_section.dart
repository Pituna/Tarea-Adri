import 'package:flutter/material.dart';

const List<String> hobbies = [
  'Correr con la piva',
  'Programar con Adrian',
  'Ir al monte',
  'Jugar al WoW',
  'Música negra',
  'Dormir',
];

class HobbiesSection extends StatelessWidget {
  const HobbiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HobbyItem(text: hobbies[0]),
              const SizedBox(height: 10),
              HobbyItem(text: hobbies[1]),
              const SizedBox(height: 10),
              HobbyItem(text: hobbies[2]),
              const SizedBox(height: 10),
              HobbyItem(text: hobbies[3]),
              const SizedBox(height: 10),
              const HobbyItem(text: 'Videojuegos'),
              const SizedBox(height: 10),
              const HobbyItem(text: 'Domingos de peliculas'),
            ],
          ),
          const SizedBox(width: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const HobbyItem(text: 'Ir a la playa'),
              const SizedBox(height: 10),
              HobbyItem(text: hobbies[4]),
              const SizedBox(height: 10),
              HobbyItem(text: hobbies[5]),
              const SizedBox(height: 10),
              const HobbyItem(text: 'Dia con mis perros'),
              const SizedBox(height: 10),
              const HobbyItem(text: 'Jugar al padel'),
              const SizedBox(height: 10),
              const HobbyItem(text: 'Hacer masajes'),
            ],
          ),
        ],
      ),
    );
  }
}

class HobbyItem extends StatelessWidget {
  final String text;

  const HobbyItem({
    super.key,
    required this.text,
  });

  static const EdgeInsets itemPadding = EdgeInsets.symmetric(
    horizontal: 8,
    vertical: 4,
  );

  static const TextStyle itemTextStyle = TextStyle(
    color: Colors.black,
    fontSize: 16,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blue[50],
        border: Border.all(
          color: Colors.grey,
          width: 2,
        ),
      ),
      child: Center(
        child: Padding(
          padding: itemPadding,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              text,
              style: itemTextStyle,
            ),
          ),
        ),
      ),
    );
  }
}