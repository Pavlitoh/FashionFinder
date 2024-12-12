import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:proyectofinal/domain/datasources/producto_datasource.dart';
import 'package:proyectofinal/entities/producto.dart';

class ProductFormScreen extends StatefulWidget {
  final String storeId;

  const ProductFormScreen({required this.storeId});

  @override
  _ProductFormScreenState createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

  void _createProduct() async {
    if (_formKey.currentState!.validate()) {
      try {
        await ProductDatasource().createProduct(Product(
          id: '',
          name: _nameController.text.trim(),
          description: _descriptionController.text.trim(),
          price: double.parse(_priceController.text.trim()),
          store_id: widget.storeId,
          image: _imageController.text.trim().isNotEmpty ? _imageController.text.trim() : null,
        ));

        // Redirigir explícitamente a la lista de productos
        context.go('/productos/${widget.storeId}');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error al crear el producto: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crear Producto"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Nombre del Producto"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "El nombre es obligatorio";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: "Descripción"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "La descripción es obligatoria";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: "Precio"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "El precio es obligatorio";
                  }
                  if (double.tryParse(value) == null) {
                    return "Debe ser un número válido";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imageController,
                decoration: const InputDecoration(labelText: "URL de la Imagen"),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _createProduct,
                child: const Text("Crear Producto"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
