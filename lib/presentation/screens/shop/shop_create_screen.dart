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
      appBar: AppBar(title: Text("Crear Tienda")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Nombre"),
                validator: (value) => value!.isEmpty ? "El nombre es requerido" : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: "Descripción"),
                validator: (value) => value!.isEmpty ? "La descripción es requerida" : null,
              ),
              TextFormField(
                controller: _categoryController,
                decoration: InputDecoration(labelText: "ID de Categoría"),
                validator: (value) => value!.isEmpty ? "El ID de categoría es requerido" : null,
              ),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: "Dirección"),
                validator: (value) => value!.isEmpty ? "La dirección es requerida" : null,
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: "Teléfono"),
                validator: (value) => value!.isEmpty ? "El teléfono es requerido" : null,
              ),
              TextFormField(
                controller: _websiteController,
                decoration: InputDecoration(labelText: "Sitio Web (Opcional)"),
              ),
              TextFormField(
                controller: _imageController,
                decoration: InputDecoration(labelText: "Enlace de Imagen (Opcional)"),
                validator: (value) {
                  if (value!.isNotEmpty && !Uri.tryParse(value)!.isAbsolute) {
                    return "El enlace de la imagen no es válido";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _createStore,
                child: Text("Crear Tienda"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
