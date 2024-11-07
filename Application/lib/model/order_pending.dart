class OrderPending {
  int? orderPendingId;
  String? customerName;
  String? employeeName;
  String? odertDate;
  String? status;
  List<ListProductOrederPending>? listProductOrederPending;

  OrderPending({
    this.orderPendingId,
    this.customerName,
    this.employeeName,
    this.odertDate,
    this.status,
    this.listProductOrederPending,
  });

  OrderPending.fromJson(Map<String, dynamic> json) {
    orderPendingId = json['orderPendingId'];
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
  String? productName;
  int? amount;

  ListProductOrederPending({
    this.productOrderPendingId,
    this.productName,
    this.amount,
  });

  ListProductOrederPending.fromJson(Map<String, dynamic> json) {
    productOrderPendingId = json['productOrderPendingId'];
    productName = json['productName'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productOrderPendingId'] = productOrderPendingId;
    data['productName'] = productName;
    data['amount'] = amount;
    return data;
  }
}
