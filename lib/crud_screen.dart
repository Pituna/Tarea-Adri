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

    final resultado = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) => AlertDialog(
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
                  labelText: 'Descripción',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                textCapitalization: TextCapitalization.sentences,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              final nombre = nombreController.text.trim();
              final descripcion = descripcionController.text.trim();
              if (nombre.isEmpty || descripcion.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Rellena el nombre y la descripción')),
                );
                return;
              }
              Navigator.pop(context, {
                'nombre': nombre,
                'descripcion': descripcion,
              });
            },
            child: Text(esEdicion ? 'Guardar' : 'Añadir'),
          ),
        ],
      ),
    );

    nombreController.dispose();
    descripcionController.dispose();

    if (resultado == null) return;

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
      builder: (context) => AlertDialog(
        title: const Text('Eliminar elemento'),
        content: Text('¿Quieres eliminar "${_elementos[indice]['nombre']}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirmar == true) {
      setState(() => _elementos.removeAt(indice));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Elemento eliminado')),
        );
      }
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
          const Text('Añade, consulta, modifica o elimina elementos del gimnasio.'),
          const SizedBox(height: 16),
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
                ? const Center(child: Text('No hay elementos. Añade uno nuevo.'))
                : ListView.builder(
                    itemCount: _elementos.length,
                    itemBuilder: (context, indice) {
                      final elemento = _elementos[indice];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            child: Icon(Icons.fitness_center),
                          ),
                          title: Text(elemento['nombre'] ?? ''),
                          subtitle: Text(elemento['descripcion'] ?? ''),
                          isThreeLine: true,
                          trailing: PopupMenuButton<String>(
                            onSelected: (opcion) {
                              if (opcion == 'editar') {
                                _mostrarFormulario(indice: indice);
                              } else if (opcion == 'eliminar') {
                                _eliminarElemento(indice);
                              }
                            },
                            itemBuilder: (context) => const [
                              PopupMenuItem(
                                value: 'editar',
                                child: Text('Editar'),
                              ),
                              PopupMenuItem(
                                value: 'eliminar',
                                child: Text('Eliminar'),
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
