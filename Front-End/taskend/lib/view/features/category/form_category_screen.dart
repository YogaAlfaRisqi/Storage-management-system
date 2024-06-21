import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskend/controller/category_provider.dart';
import 'package:taskend/controller/product_provider.dart';
import 'package:taskend/models/category/category_model.dart';

class EditFormCategory extends StatefulWidget {
  final Category? category;
  const EditFormCategory({this.category, super.key});

  @override
  _EditFormCategoryState createState() => _EditFormCategoryState();
}

class _EditFormCategoryState extends State<EditFormCategory> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    final categoryProvider = context.read<CategoryProvider>();

    _nameController = TextEditingController(text: widget.category?.name ?? '');

    categoryProvider.setFormControllers(
      _nameController,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
  }

  void _saveForm() {
    if (context.read<CategoryProvider>().formKey.currentState!.validate()) {
      final category = Category(
        id: widget.category?.id,
        name: _nameController.text,
      );

      if (widget.category == null) {
        context.read<CategoryProvider>().insertCategory();
      } else {
        context.read<CategoryProvider>().updateCategory(category);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    var categoryProvider = context.watch<CategoryProvider>();
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: categoryProvider.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: categoryProvider.nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveForm,
                child: Text(widget.category == null
                    ? 'Add Category'
                    : 'Update Category'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
