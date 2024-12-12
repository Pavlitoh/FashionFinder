import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proyectofinal/domain/datasources/store_datasource.dart';
import 'package:proyectofinal/entities/store.dart';

class ShopCreateScreen extends StatefulWidget {
  @override
  _ShopCreateScreenState createState() => _ShopCreateScreenState();
}

class _ShopCreateScreenState extends State<ShopCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _websiteController = TextEditingController();
  final _imageController = TextEditingController(); // Campo para el enlace de la imagen

  void _createStore() async {
    if (_formKey.currentState!.validate()) {
      final datasource = StoreDatasource();

      try {
        await datasource.createStore(
          Store(
            id: '', // El backend lo generará
            name: _nameController.text,
            description: _descriptionController.text,
            categoryId: _categoryController.text,
            mainAddress: _addressController.text,
            mainPhone: _phoneController.text,
            website: _websiteController.text.isEmpty ? null : _websiteController.text,
            image: _imageController.text.isEmpty ? null : _imageController.text, // Enlace de la imagen
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        );

        // Redirige a la lista de tiendas después de crear
        context.go('/shops');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al crear la tienda: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crear Tienda"),
        backgroundColor: Colors.pinkAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/shops');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Nombre",
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? "El nombre es requerido" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: "Descripción",
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? "La descripción es requerida" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(
                  labelText: "ID de Categoría",
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? "El ID de categoría es requerido" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: "Dirección",
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? "La dirección es requerida" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: "Teléfono",
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? "El teléfono es requerido" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _websiteController,
                decoration: const InputDecoration(
                  labelText: "Sitio Web (Opcional)",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _imageController,
                decoration: const InputDecoration(
                  labelText: "Enlace de Imagen (Opcional)",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isNotEmpty && !Uri.tryParse(value)!.isAbsolute) {
                    return "El enlace de la imagen no es válido";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _createStore,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Crear Tienda",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  context.go('/shops');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purpleAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Volver a la Lista de Tiendas",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
