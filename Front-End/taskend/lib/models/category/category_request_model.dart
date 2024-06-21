class CategoryRequestModel {
  String? name;
  // String? comment;

  CategoryRequestModel({this.name});

  CategoryRequestModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subject'] = name;

    return data;
  }
}
