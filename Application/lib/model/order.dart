import 'package:shopping_app/model/address.dart';
import 'package:shopping_app/model/color.dart';
import 'package:shopping_app/model/product.dart';

class Order {
  int? orderId;
  int? customerId;
  String? customerName;
  int? employeeId;
  String? employeeName;
  String? odertDate;
  Store? store;
  String? status;
  String? orderType;
  String? dateExport;
  int? orderPendingId;
  List<ListProductOrder>? listProductOrder;

  Order({
    this.orderId,
    this.customerId,
    this.customerName,
    this.employeeId,
    this.employeeName,
    this.odertDate,
    this.store,
    this.status,
    this.orderType,
    this.dateExport,
    this.orderPendingId,
    this.listProductOrder,
  });

  Order.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    customerId = json['customerId'];
    customerName = json['customerName'];
    employeeId = json['employeeId'];
    employeeName = json['employeeName'];
    odertDate = json['odertDate'];
    store = json['store'] != null ? Store.fromJson(json['store']) : null;
    status = json['status'];
    orderType = json['orderType'];
    dateExport = json['dateExport'];
    orderPendingId = json['orderPendingId'];
    if (json['listProductOrder'] != null) {
      listProductOrder = <ListProductOrder>[];
      json['listProductOrder'].forEach((v) {
        listProductOrder!.add(ListProductOrder.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderId'] = orderId;
    data['customerId'] = customerId;
    data['customerName'] = customerName;
    data['employeeId'] = employeeId;
    data['employeeName'] = employeeName;
    data['odertDate'] = odertDate;
    if (store != null) {
      data['store'] = store!.toJson();
    }
    data['status'] = status;
    data['orderType'] = orderType;
    data['dateExport'] = dateExport;
    data['orderPendingId'] = orderPendingId;
    if (listProductOrder != null) {
      data['listProductOrder'] =
          listProductOrder!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Store {
  int? storeId;
  String? storeName;
  Address? address;

  Store({this.storeId, this.storeName, this.address});

  Store.fromJson(Map<String, dynamic> json) {
    storeId = json['storeId'];
    storeName = json['storeName'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['storeId'] = storeId;
    data['storeName'] = storeName;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    return data;
  }
}

class ListProductOrder {
  int? productOrderId;
  int? orderId;
  Product? product;
  int? amount;
  Color? color;
  double? untilPrice;

  ListProductOrder(
      {this.productOrderId,
      this.orderId,
      this.product,
      this.amount,
      this.color,
      this.untilPrice});

  ListProductOrder.fromJson(Map<String, dynamic> json) {
    productOrderId = json['productOrderId'];
    orderId = json['orderId'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
    amount = json['amount'];
    color = json['color'] != null ? Color.fromJson(json['color']) : null;
    untilPrice = json['untilPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productOrderId'] = productOrderId;
    data['orderId'] = orderId;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    data['amount'] = amount;
    if (color != null) {
      data['color'] = color!.toJson();
    }
    data['untilPrice'] = untilPrice;
    return data;
  }
}
