class CategoryModel {
  List<Category>? category;

  CategoryModel({this.category});

  CategoryModel.fromJson(List<dynamic> json) {
    category = <Category>[];
    json.forEach((v) {
      category!.add(Category.fromJson(v));
    });
  }

  List<dynamic> toJson() {
    List<dynamic> data = <dynamic>[];
    if (category != null) {
      data = category!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  int? id;
  String? name;
  String? url;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? createdBy;
  String? updatedBy;

  Category({
    this.id,
    this.name,
    this.url,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
  });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
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
    data['url'] = url;
    data['createdAt'] = createdAt?.toIso8601String();
    data['updatedAt'] = updatedAt?.toIso8601String();
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    return data;
  }
}
