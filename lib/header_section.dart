import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Cabecera con el título del portfolio
        Container(
          width: double.infinity,
          height: 40,
          color: Colors.yellow,
          child: const Center(
            child: Text(
              'Este es mi segundo portfolio, de Jose',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        // Presentación personal con fotografía
        Container(
          width: double.infinity,
          height: 120,
          padding: const EdgeInsets.all(10),
          color: Colors.grey[200],
          child: Row(
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'assets/images/imagesss.jpeg',
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 15),

              const Expanded(
                child: Text(
                  'Soy Jose y estas son mis aficiones'
                  'PD: te quiero adrian',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}