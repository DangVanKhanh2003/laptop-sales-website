import 'package:shopping_app/model/sale.dart';

class OrderPending {
  int? orderPendingId;
  int? customerId;
  String? employeeId;
  String? customerName;
  String? employeeName;
  String? odertDate;
  String? status;
  List<ListProductOrederPending>? listProductOrederPending;

  OrderPending({
    this.orderPendingId,
    this.customerId,
    this.employeeId,
    this.customerName,
    this.employeeName,
    this.odertDate,
    this.status,
    this.listProductOrederPending,
  });

  OrderPending.fromJson(Map<String, dynamic> json) {
    orderPendingId = json['orderPendingId'];
    customerId = json['customerId'];
    employeeId = json['employeeId'];
    customerName = json['customerName'];
    employeeName = json['employeeName'];
    odertDate = json['odertDate'];
    status = json['status'];
    if (json['listProductOrederPending'] != null) {
      listProductOrederPending = <ListProductOrederPending>[];
      json['listProductOrederPending'].forEach((v) {
        listProductOrederPending!.add(ListProductOrederPending.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderPendingId'] = orderPendingId;
    data['customerId'] = customerId;
    data['employeeId'] = employeeId;
    data['customerName'] = customerName;
    data['employeeName'] = employeeName;
    data['odertDate'] = odertDate;
    data['status'] = status;
    if (listProductOrederPending != null) {
      data['listProductOrederPending'] =
          listProductOrederPending!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListProductOrederPending {
  int? productOrderPendingId;
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

  ListProductOrederPending(
      {this.productOrderPendingId,
      this.productId,
      this.productName,
      this.amount,
      this.colorName,
      this.brand,
      this.series,
      this.price,
      this.categoryName,
      this.mainImg,
      this.sale});

  ListProductOrederPending.fromJson(Map<String, dynamic> json) {
    productOrderPendingId = json['productOrderPendingId'];
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
    data['productOrderPendingId'] = productOrderPendingId;
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
