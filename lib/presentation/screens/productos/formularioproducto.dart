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
          image: _imageController.text.trim().isNotEmpty
              ? _imageController.text.trim()
              : null,
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
        backgroundColor: Colors.pinkAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/productos/${widget.storeId}'); // Regresar a la lista de productos
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Registrar Producto",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.purpleAccent,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "Nombre del Producto",
                    prefixIcon: const Icon(Icons.shopping_bag),
                    filled: true,
                    fillColor: Colors.pinkAccent.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "El nombre es obligatorio";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: "Descripción",
                    prefixIcon: const Icon(Icons.description),
                    filled: true,
                    fillColor: Colors.pinkAccent.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "La descripción es obligatoria";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(
                    labelText: "Precio",
                    prefixIcon: const Icon(Icons.attach_money),
                    filled: true,
                    fillColor: Colors.pinkAccent.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
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
                const SizedBox(height: 16),
                TextFormField(
                  controller: _imageController,
                  decoration: InputDecoration(
                    labelText: "URL de la Imagen",
                    prefixIcon: const Icon(Icons.image),
                    filled: true,
                    fillColor: Colors.pinkAccent.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _createProduct,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Crear Producto",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
