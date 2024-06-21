class ProductModel {
  List<Product>? products;

  ProductModel({this.products});

  ProductModel.fromJson(List<dynamic> json) {
    products = <Product>[];
    json.forEach((v) {
      products!.add(Product.fromJson(v));
    });
  }

  List<dynamic> toJson() {
    List<dynamic> data = <dynamic>[];
    if (products != null) {
      data = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  int? id;
  String? name;
  int? qty;
  int? categoryId;
  String? url;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? createdBy;
  String? updatedBy;

  Product({
    this.id,
    this.name,
    this.qty,
    this.categoryId,
    this.url,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    qty = json['qty'];
    categoryId = json['categoryId'];
    url = json['url'];
    createdAt = DateTime.parse(json['createdAt']);
    updatedAt = DateTime.parse(json['updatedAt']);
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['qty'] = qty;
    data['categoryId'] = categoryId;
    data['url'] = url;
    data['createdAt'] = createdAt?.toIso8601String();
    data['updatedAt'] = updatedAt?.toIso8601String();
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    return data;
  }
}
