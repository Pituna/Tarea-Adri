import 'package:flutter/material.dart';

class CrudScreen extends StatefulWidget {
  const CrudScreen({super.key});

  @override
  State<CrudScreen> createState() => _CrudScreenState();
}

class _CrudScreenState extends State<CrudScreen> {
  final List<Map<String, String>> _elementos = [
    {'nombre': 'Clases dirigidas', 'descripcion': 'Actividades en grupo para los socios'},
    {'nombre': 'Máquinas y zonas', 'descripcion': 'Equipamiento disponible en el gimnasio'},
    {'nombre': 'Entrenadores', 'descripcion': 'Personal que ayuda a los usuarios'},
    {'nombre': 'Actividades y horarios', 'descripcion': 'Calendario de actividades del gimnasio'},
  ];

  Future<void> _mostrarFormulario({int? indice}) async {
    final esEdicion = indice != null;
    final nombreController = TextEditingController(
      text: esEdicion ? _elementos[indice]['nombre'] : '',
    );
    final descripcionController = TextEditingController(
      text: esEdicion ? _elementos[indice]['descripcion'] : '',
    );

    
  }
}
