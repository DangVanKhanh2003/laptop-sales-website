import 'package:shopping_app/model/sale.dart';

class Cart {
  int? customerId;
  int? productId;
  int? amount;
  int? colorId;

  Cart({
    this.customerId,
    this.productId,
    this.amount,
    this.colorId,
  });

  Cart.fromJson(Map<String, dynamic> json) {
    customerId = json['customerId'];
    productId = json['productId'];
    amount = json['amount'];
    colorId = json['colorId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customerId'] = customerId;
    data['productId'] = productId;
    data['amount'] = amount;
    data['colorId'] = colorId;
    return data;
  }
}

class CartItem {
  int? shoppingCartItemId;
  int? customerId;
  int? productId;
  String? productName;
  int? amount;
  String? colorName;
  String? brand;
  String? series;
  double? price;
  String? categoryName;
  String? mainImg;
  Sale? sale;

  CartItem({
    this.shoppingCartItemId,
    this.customerId,
    this.productId,
    this.productName,
    this.amount,
    this.colorName,
    this.brand,
    this.series,
    this.price,
    this.categoryName,
    this.mainImg,
    this.sale,
  });

  CartItem.fromJson(Map<String, dynamic> json) {
    shoppingCartItemId = json['shoppingCartItemId'];
    customerId = json['customerId'];
    productId = json['productId'];
    productName = json['productName'];
    amount = json['amount'];
    colorName = json['colorName'];
    brand = json['brand'];
    series = json['series'];
    price = json['price'];
    categoryName = json['categoryName'];
    mainImg = json['mainImg'];
    sale = json['sale'] != null ? Sale.fromJson(json['sale']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['shoppingCartItemId'] = shoppingCartItemId;
    data['customerId'] = customerId;
    data['productId'] = productId;
    data['productName'] = productName;
    data['amount'] = amount;
    data['colorName'] = colorName;
    data['brand'] = brand;
    data['series'] = series;
    data['price'] = price;
    data['categoryName'] = categoryName;
    data['mainImg'] = mainImg;
    if (sale != null) {
      data['sale'] = sale!.toJson();
    }
    return data;
  }
}

class CartList {
  List<CartItem>? items;

  CartList({
    this.items,
  });

  CartList.fromJson(List<dynamic> json) {
    items = json.map((e) => CartItem.fromJson(e)).toList();
  }

  List<dynamic> toJson() {
    final List<dynamic> result = [];
    for (final e in items!) {
      result.add(e.toJson());
    }
    return result;
  }
}
