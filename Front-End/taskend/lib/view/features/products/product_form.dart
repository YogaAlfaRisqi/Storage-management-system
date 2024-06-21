import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskend/controller/product_provider.dart';
import 'package:taskend/models/product/product_model.dart';

class EditFormProduct extends StatefulWidget {
  final Product? product;
  const EditFormProduct({this.product, super.key});

  @override
  _EditFormProductState createState() => _EditFormProductState();
}

class _EditFormProductState extends State<EditFormProduct> {
  late TextEditingController _nameController;
  late TextEditingController _urlController;
  late TextEditingController _categoryIdController;
  late TextEditingController _qtyController;

  @override
  void initState() {
    super.initState();
    final productProvider = context.read<ProductProvider>();

    _nameController = TextEditingController(text: widget.product?.name ?? '');
    _urlController = TextEditingController(text: widget.product?.url ?? '');
    _categoryIdController = TextEditingController(
        text: widget.product?.categoryId?.toString() ?? '');
    _qtyController =
        TextEditingController(text: widget.product?.qty?.toString() ?? '');

    productProvider.setFormControllers(
      _nameController,
      _urlController,
      _categoryIdController,
      _qtyController,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _urlController.dispose();
    _categoryIdController.dispose();
    _qtyController.dispose();
    super.dispose();
  }

  void _saveForm() {
    if (context.read<ProductProvider>().formKey.currentState!.validate()) {
      final product = Product(
        id: widget.product?.id,
        name: _nameController.text,
        url: _urlController.text,
        categoryId: int.tryParse(_categoryIdController.text),
        qty: int.tryParse(_qtyController.text),
      );

      if (widget.product == null) {
        context.read<ProductProvider>().insertProduct(product);
      } else {
        context.read<ProductProvider>().updateProduct(product);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    var productProvider = context.watch<ProductProvider>();
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: productProvider.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: productProvider.nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: productProvider.urlController,
                decoration: const InputDecoration(labelText: 'Image URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an image URL';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: productProvider.categoryIdController,
                decoration: const InputDecoration(labelText: 'Category ID'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a category ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: productProvider.qtyController,
                decoration: const InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a quantity';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveForm,
                child: Text(
                    widget.product == null ? 'Add Product' : 'Update Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
