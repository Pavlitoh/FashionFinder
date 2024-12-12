import 'package:flutter/material.dart';
import 'package:proyectofinal/presentation/screens/home/categorias_view/categorias_view.dart';
import 'package:proyectofinal/presentation/shared/fondo.dart';

class DetalleSucursalPage extends StatelessWidget {
  final String nombre;
  final String direccion;
  final String latitud;
  final String longitud;
  final String servicios;
  final String horario;
  final String imagenUrl;
  final String categoryId;

  const DetalleSucursalPage({
    super.key,
    required this.nombre,
    required this.direccion,
    required this.latitud,
    required this.longitud,
    required this.servicios,
    required this.horario,
    required this.imagenUrl,
    required this.categoryId, // Se agrega al constructor
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detalle de Sucursal",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Fondo(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              if (imagenUrl.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    imagenUrl,
                    fit: BoxFit.cover,
                    height: 200,
                    width: double.infinity,
                  ),
                ),
              const SizedBox(height: 16),

              Text(
                nombre,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              ListTile(
                leading: const Icon(Icons.location_on, color: Colors.black),
                title: const Text(
                  'Dirección',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(direccion),
              ),
              const Divider(),

              ListTile(
                leading: const Icon(Icons.map, color: Colors.black),
                title: const Text(
                  'Coordenadas',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Latitud: $latitud\nLongitud: $longitud'),
              ),
              const Divider(),

              ListTile(
                leading: const Icon(Icons.room_service, color: Colors.black),
                title: const Text(
                  'Servicios',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(servicios),
              ),
              const Divider(),

              ListTile(
                leading: const Icon(Icons.access_time, color: Colors.black),
                title: const Text(
                  'Horario',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(horario),
              ),
              const Divider(),

              // Agregar el nuevo campo categoryId
              ListTile(
                leading: const Icon(Icons.category, color: Colors.black),
                title: const Text(
                  'Category ID',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(categoryId), // Muestra el categoryId
              ),
              const Divider(),

              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Regresar'),
              ),
              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: () {
                  // Aquí puedes definir la acción que se debe realizar
                  // al presionar el botón "Ver Tiendas"
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeView(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Cambia el color si lo deseas
                  foregroundColor: Colors.white,
                ),
                child: const Text('Ver Tiendas'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
