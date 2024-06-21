import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskend/controller/category_provider.dart';
import 'package:taskend/models/category/category_model.dart';
import 'package:taskend/view/features/category/form_category_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryProvider>().getAll();
  }

  void _showCategoryForm({Category? category}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: EditFormCategory(category: category),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Category',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.teal,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCategoryForm(),
        child: const Icon(Icons.add),
      ),
      body: bodyData(context, context.watch<CategoryProvider>().state),
    );
  }

  Widget bodyData(BuildContext context, CategoryState state) {
    switch (state) {
      case CategoryState.success:
        var dataResult = context.watch<CategoryProvider>().listCategory;
        return ListView.builder(
          padding: EdgeInsets.all(16.0),
          itemCount: dataResult!.length,
          itemBuilder: (context, index) => Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      dataResult[index].name ?? '',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _showCategoryForm(
                            category: dataResult[
                                index]), // Implement onEdit action here
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          context.read<CategoryProvider>().deleteCategory(
                              context, dataResult[index].id ?? 0);
                        }, // // Implement onDelete action here
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      case CategoryState.nodata:
        return const Center(
          child: Text('No Data Category'),
        );
      case CategoryState.error:
        return Center(
          child: Text(context.watch<CategoryProvider>().messageError),
        );
      default:
        return const Center(child: CircularProgressIndicator());
    }
  }
}
