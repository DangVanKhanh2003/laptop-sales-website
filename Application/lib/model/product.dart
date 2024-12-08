import './sale.dart';
import './category.dart';

class Product {
  int? productId;
  String? productName;
  String? brand;
  String? series;
  double? price;
  Category? category;
  String? mainImg;
  Sale? sale;

  Product({
    this.productId,
    this.productName,
    this.brand,
    this.series,
    this.price,
    this.category,
    this.mainImg,
    this.sale,
  });

  Product.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    productName = json['productName'];
    brand = json['brand'];
    series = json['series'];
    price = json['price'];
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    mainImg = json['mainImg'];
    sale = json['sale'] != null ? Sale.fromJson(json['sale']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['productName'] = productName;
    data['brand'] = brand;
    data['series'] = series;
    data['price'] = price;
    data['category'] = category;
    data['mainImg'] = mainImg;
    data['sale'] = sale;
    return data;
  }
}

// -----------------------

class ProductList {
  List<Product>? productList;

  ProductList({
    this.productList,
  });

  ProductList.fromJson(List<dynamic> json) {
    productList = json.map((e) => Product.fromJson(e)).toList();
  }

  List<dynamic> toJson() {
    final List<dynamic> result = [];
    for (var e in productList!) {
      result.add(e);
    }
    return result;
  }

  void addProducts(ProductList other) {
    productList!.addAll(other.productList!);
  }
}

// -----------------------

class ProductSpecificationList {
  List<ProductSpecification>? productSpecificationList;

  ProductSpecificationList({
    this.productSpecificationList,
  });

  ProductSpecificationList.fromJson(List<dynamic> json) {
    productSpecificationList =
        json.map((e) => ProductSpecification.fromJson(e)).toList();
  }

  List<dynamic> toJson() {
    final List<dynamic> result = [];
    for (var e in productSpecificationList!) {
      result.add(e);
    }
    return result;
  }

  void addProducts(ProductSpecificationList other) {
    productSpecificationList!.addAll(other.productSpecificationList!);
  }
}

class ProductSpecification {
  int? specifiactionsId;
  String? specType;
  String? description;
  int? productId;

  ProductSpecification({
    this.specifiactionsId,
    this.specType,
    this.description,
    this.productId,
  });

  ProductSpecification.fromJson(Map<String, dynamic> json) {
    specifiactionsId = json['specifiactionsId'];
    specType = json['specType'];
    description = json['description'];
    productId = json['productId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['specifiactionsId'] = specifiactionsId;
    data['specType'] = specType;
    data['description'] = description;
    data['productId'] = productId;
    return data;
  }
}
