class Category {
  int? categoryId;
  String? categoryName;
  String? categoryIcon;

  Category({
    this.categoryId,
    this.categoryName,
    this.categoryIcon,
  });

  Category.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    categoryIcon = json['categoryIcon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryId'] = categoryId;
    data['categoryName'] = categoryName;
    data['categoryIcon'] = categoryIcon;
    return data;
  }
}

class CategoryList {
  List<Category>? categoryList;

  CategoryList({this.categoryList});

  CategoryList.fromJson(List<dynamic> json) {
    categoryList = json.map((e) => Category.fromJson(e)).toList();
  }

  List<dynamic> toJson() {
    final List<dynamic> result = [];
    for (final e in categoryList!) {
      result.add(e.toJson());
    }
    return result;
  }
}
