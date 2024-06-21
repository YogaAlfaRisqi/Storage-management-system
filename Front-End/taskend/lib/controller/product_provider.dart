import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:taskend/constants/url.dart';
import 'package:taskend/models/product/product_model.dart';

class ProductProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController categoryIdController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  List<Product>? listProduct;
  var state = ProductState.initial;
  var messageError = '';

  final dio = Dio();
  final _baseUrl = AppUrl.baseUrl;

  void setFormControllers(
    TextEditingController name,
    TextEditingController url,
    TextEditingController categoryId,
    TextEditingController qty,
  ) {
    nameController = name;
    urlController = url;
    categoryIdController = categoryId;
    qtyController = qty;
  }

  Future getAll() async {
    try {
      var response = await dio.get("$_baseUrl/products");
      var result = ProductModel.fromJson(response.data);

      if (result.products!.isEmpty) {
        state = ProductState.nodata;
      } else {
        state = ProductState.success;
        listProduct = result.products;
      }
    } catch (e) {
      state = ProductState.error;
      messageError = e.toString();
    }
    notifyListeners();
  }

  Future insertProduct(Product product) async {
    try {
      var requestModel = {
        "name": product.name,
        "url": product.url,
        "categoryId": product.categoryId,
        "qty": product.qty
      };
      await dio.post(
        "$_baseUrl/products/add",
        data: requestModel,
      );

      getAll();
    } catch (e) {
      messageError = e.toString();
    }
    notifyListeners();
  }

  Future updateProduct(Product product) async {
    try {
      var requestModel = {
        "id": product.id,
        "name": product.name,
        "url": product.url,
        "categoryId": product.categoryId,
        "qty": product.qty
      };
      await dio.put('$_baseUrl/products/update/${product.id}',
          data: requestModel);
      getAll();
    } catch (e) {
      messageError = e.toString();
    }
    notifyListeners();
  }

  Future deleteProduct(BuildContext context, int id) async {
    try {
      await Dio().delete('$_baseUrl/products/delete/$id');
      getAll();
    } catch (e) {
      messageError = e.toString();
    }
    notifyListeners();
  }
}

enum ProductState { initial, loading, success, error, nodata }
