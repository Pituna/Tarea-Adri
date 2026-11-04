import 'package:flutter/material.dart';

class CrudScreen extends StatefulWidget {
  const CrudScreen({super.key});

  @override
  State<CrudScreen> createState() => _CrudScreenState();
}

class _CrudScreenState extends State<CrudScreen> {
  static const List<String> _categorias = [
    'Clases dirigidas',
    'Máquinas y zonas',
    'Entrenadores',
    'Actividades',
  ];

  final List<Map<String, String>> _elementos = [
    {
      'nombre': 'Clases dirigidas',
      'descripcion': 'Actividades en grupo para los socios.',
      'categoria': 'Clases dirigidas',
    },
    {
      'nombre': 'Máquinas y zonas',
      'descripcion': 'Equipamiento disponible en el gimnasio.',
      'categoria': 'Máquinas y zonas',
    },
    {
      'nombre': 'Entrenadores',
      'descripcion': 'Personal que ayuda a los usuarios.',
      'categoria': 'Entrenadores',
    },
    {
      'nombre': 'Actividades y horarios',
      'descripcion': 'Calendario de actividades del gimnasio.',
      'categoria': 'Actividades',
    },
  ];

  Color _colorCategoria(String? categoria) {
    switch (categoria) {
      case 'Clases dirigidas':
        return Colors.deepPurple;
      case 'Máquinas y zonas':
        return Colors.blue;
      case 'Entrenadores':
        return Colors.teal;
      case 'Actividades':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }


  String _imagenCategoria(String? categoria) {
    switch (categoria) {
      case 'Clases dirigidas':
        return 'assets/images/categoria_clases.png';
      case 'Máquinas y zonas':
        return 'assets/images/categoria_maquinas.png';
      case 'Entrenadores':
        return 'assets/images/categoria_entrenadores.png';
      case 'Actividades':
        return 'assets/images/categoria_actividades.png';
      default:
        return 'assets/images/categoria_actividades.png';
    }
  }

  Future<void> _mostrarFormulario({int? indice}) async {
    final esEdicion = indice != null;
    final elementoActual = esEdicion ? _elementos[indice] : null;
    final nombreController = TextEditingController(
      text: elementoActual?['nombre'] ?? '',
    );
    final descripcionController = TextEditingController(
      text: elementoActual?['descripcion'] ?? '',
    );
    String categoriaSeleccionada =
        elementoActual?['categoria'] ?? _categorias.first;

    final resultado = await showDialog<Map<String, String>>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, actualizarDialogo) => AlertDialog(
          title: Text(esEdicion ? 'Editar elemento' : 'Añadir elemento'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nombreController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                    border: OutlineInputBorder(),
                  ),
                  textCapitalization: TextCapitalization.sentences,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: descripcionController,
                  decoration: const InputDecoration(
                    labelText: 'Descripción breve',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  textCapitalization: TextCapitalization.sentences,
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: categoriaSeleccionada,
                  decoration: const InputDecoration(
                    labelText: 'Categoría',
                    border: OutlineInputBorder(),
                  ),
                  items: _categorias.map((categoria) {
                    return DropdownMenuItem<String>(
                      value: categoria,
                      child: Text(categoria),
                    );
                  }).toList(),
                  onChanged: (valor) {
                    if (valor != null) {
                      actualizarDialogo(() {
                        categoriaSeleccionada = valor;
                      });
                    }
                  },
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        _imagenCategoria(categoriaSeleccionada),
                        width: 44,
                        height: 44,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Imagen de la categoría seleccionada',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                final nombre = nombreController.text.trim();
                final descripcion = descripcionController.text.trim();

                if (nombre.isEmpty || descripcion.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Rellena el nombre y la descripción'),
                    ),
                  );
                  return;
                }

                Navigator.pop(dialogContext, {
                  'nombre': nombre,
                  'descripcion': descripcion,
                  'categoria': categoriaSeleccionada,
                });
              },
              child: Text(esEdicion ? 'Guardar' : 'Añadir'),
            ),
          ],
        ),
      ),
    );

    nombreController.dispose();
    descripcionController.dispose();

    if (resultado == null || !mounted) return;

    setState(() {
      if (esEdicion) {
        _elementos[indice] = resultado;
      } else {
        _elementos.add(resultado);
      }
    });
  }

  Future<void> _eliminarElemento(int indice) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Eliminar elemento'),
        content: Text('¿Quieres eliminar "${_elementos[indice]['nombre']}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirmar == true && mounted) {
      setState(() => _elementos.removeAt(indice));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Elemento eliminado')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Gestión de elementos',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          const Text(
            'Añade, consulta, modifica o elimina elementos del gimnasio.',
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              const Icon(Icons.list_alt, color: Colors.blue),
              const SizedBox(width: 8),
              const Text(
                'Total de elementos:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 8),
              CircleAvatar(
                radius: 15,
                backgroundColor: Colors.blue,
                child: Text(
                  '${_elementos.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _mostrarFormulario(),
              icon: const Icon(Icons.add),
              label: const Text('Añadir elemento'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 13),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: _elementos.isEmpty
                ? const Center(
                    child: Text('No hay elementos. Añade uno nuevo.'),
                  )
                : ListView.builder(
                    itemCount: _elementos.length,
                    itemBuilder: (context, indice) {
                      final elemento = _elementos[indice];
                      final categoria = elemento['categoria'];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          leading: ClipOval(
                            child: Image.asset(
                              _imagenCategoria(categoria),
                              width: 48,
                              height: 48,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(elemento['nombre'] ?? ''),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(elemento['descripcion'] ?? ''),
                              const SizedBox(height: 4),
                              Text(
                                'Categoría: ${categoria ?? 'Sin categoría'}',
                                style: TextStyle(
                                  color: _colorCategoria(categoria),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          isThreeLine: true,
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                tooltip: 'Editar',
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                onPressed: () =>
                                    _mostrarFormulario(indice: indice),
                              ),
                              IconButton(
                                tooltip: 'Eliminar',
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () => _eliminarElemento(indice),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
