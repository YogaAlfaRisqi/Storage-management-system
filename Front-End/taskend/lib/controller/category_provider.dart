import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:taskend/constants/url.dart';
import 'package:taskend/models/category/category_model.dart';

class CategoryProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();

  List<Category>? listCategory;
  var state = CategoryState.initial;
  var messageError = '';

  final dio = Dio();
  final _baseUrl = AppUrl.baseUrl;

  void setFormControllers(
    TextEditingController name,
  ) {
    nameController = name;
  }

  Future getAll() async {
    try {
      var response = await dio.get("$_baseUrl/category");
      var result = CategoryModel.fromJson(response.data);

      if (result.category!.isEmpty) {
        state = CategoryState.nodata;
      } else {
        state = CategoryState.success;
        listCategory = result.category;
      }
    } catch (e) {
      state = CategoryState.error;
      messageError = e.toString();
    }
    notifyListeners();
  }

  Future insertCategory() async {
    try {
      var requestModel = {
        "name": nameController.text,
      };
      await dio.post(
        "$_baseUrl/category/add",
        data: requestModel,
      );

      getAll();
    } catch (e) {
      messageError = e.toString();
    }
    notifyListeners();
  }

  Future updateCategory(Category category) async {
    try {
      var requestModel = {
        "id": category.id,
        "name": category.name,
      };
      await dio.put('$_baseUrl/category/update/${category.id}',
          data: requestModel);
      getAll();
    } catch (e) {
      messageError = e.toString();
    }
    notifyListeners();
  }

  Future deleteCategory(BuildContext context, int id) async {
    try {
      await Dio().delete('$_baseUrl/category/delete/$id');
      getAll();
    } catch (e) {
      messageError = e.toString();
    }
    notifyListeners();
  }
}

enum CategoryState { initial, loading, success, error, nodata }
