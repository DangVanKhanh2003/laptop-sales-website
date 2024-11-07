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
