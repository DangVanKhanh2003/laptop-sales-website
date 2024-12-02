import 'package:admin/model/color.dart';
import 'package:admin/model/order.dart';
import 'package:admin/model/product.dart';

class HistorySuccess {
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

  HistorySuccess({
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

  HistorySuccess.fromJson(
    Map<String, dynamic> json,
  ) {
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

class HistoryCancel {
  String? odertDate;
  String? actorCancel;
  List<CancelProducts>? cancelProducts;

  HistoryCancel({this.odertDate, this.actorCancel, this.cancelProducts});

  HistoryCancel.fromJson(Map<String, dynamic> json) {
    odertDate = json['odertDate'];
    actorCancel = json['actorCancel'];
    if (json['cancelProducts'] != null) {
      cancelProducts = <CancelProducts>[];
      json['cancelProducts'].forEach((v) {
        cancelProducts!.add(CancelProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['odertDate'] = odertDate;
    data['actorCancel'] = actorCancel;
    if (cancelProducts != null) {
      data['cancelProducts'] = cancelProducts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CancelProducts {
  Product? product;
  int? amount;
  Color? color;
  double? untilPrice;

  CancelProducts({
    this.product,
    this.amount,
    this.color,
    this.untilPrice,
  });

  CancelProducts.fromJson(Map<String, dynamic> json) {
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
    amount = json['amount'];
    color = json['color'] != null ? Color.fromJson(json['color']) : null;
    untilPrice = json['untilPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (product != null) {
      data['product'] = product!.toJson();
    }
    data['amount'] = amount;
    data['color'] = color;
    data['untilPrice'] = untilPrice;
    return data;
  }
}
