import 'package:flutter/material.dart';
import 'package:proyectofinal/presentation/screens/sucursales/detallesucursales.dart';
import 'package:proyectofinal/presentation/shared/fondo.dart';

class FormularioSucursalPage extends StatefulWidget {
  final String? nombre;
  final String? direccion;
  final String? latitud;
  final String? longitud;
  final String? servicios;
  final String? imagenUrl;

  const FormularioSucursalPage({
    super.key,
    this.nombre,
    this.direccion,
    this.latitud,
    this.longitud,
    this.servicios,
    this.imagenUrl,
  });

  @override
  State<FormularioSucursalPage> createState() =>
      _FormularioSucursalPageState();
}

class _FormularioSucursalPageState extends State<FormularioSucursalPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _categoryIdController;
  late TextEditingController _nombreController;
  late TextEditingController _direccionController;
  late TextEditingController _latitudController;
  late TextEditingController _longitudController;
  late TextEditingController _serviciosController;
  late TextEditingController _imagenController;

  @override
  void initState() {
    super.initState();
    _categoryIdController = TextEditingController();
    _nombreController = TextEditingController(text: widget.nombre ?? "");
    _direccionController = TextEditingController(text: widget.direccion ?? "");
    _latitudController = TextEditingController(text: widget.latitud ?? "");
    _longitudController = TextEditingController(text: widget.longitud ?? "");
    _serviciosController = TextEditingController(text: widget.servicios ?? "");
    _imagenController = TextEditingController(text: widget.imagenUrl ?? "");
  }

  @override
  void dispose() {
    _categoryIdController.dispose();
    _nombreController.dispose();
    _direccionController.dispose();
    _latitudController.dispose();
    _longitudController.dispose();
    _serviciosController.dispose();
    _imagenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.nombre == null ? "Crear Sucursal" : "Editar Sucursal",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Fondo(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                // Campo para el categoryId
                TextFormField(
                  controller: _categoryIdController,
                  decoration: const InputDecoration(
                    labelText: 'Category ID',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El Category ID es obligatorio';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _nombreController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El nombre es obligatorio';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _direccionController,
                  decoration: const InputDecoration(
                    labelText: 'Dirección',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'La dirección es obligatoria';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _latitudController,
                  decoration: const InputDecoration(
                    labelText: 'Latitud',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'La latitud es obligatoria';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _longitudController,
                  decoration: const InputDecoration(
                    labelText: 'Longitud',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'La longitud es obligatoria';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _serviciosController,
                  decoration: const InputDecoration(
                    labelText: 'Servicios',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Los servicios son obligatorios';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _imagenController,
                  decoration: const InputDecoration(
                    labelText: 'URL de la Imagen',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'La URL de la imagen es obligatoria';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final categoryId = _categoryIdController.text;
                      final nombre = _nombreController.text;
                      final direccion = _direccionController.text;
                      final latitud = _latitudController.text;
                      final longitud = _longitudController.text;
                      final servicios = _serviciosController.text;
                      final imagenUrl = _imagenController.text;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetalleSucursalPage(
                            categoryId: categoryId,
                            nombre: nombre,
                            direccion: direccion,
                            latitud: latitud,
                            longitud: longitud,
                            servicios: servicios,
                            horario: "Lunes a Viernes: 9:00 AM - 6:00 PM",
                            imagenUrl: imagenUrl,
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Guardar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
