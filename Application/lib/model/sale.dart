class Sale {
  int? saleId;
  int? productId;
  int? numProduct;
  String? startAt;
  String? endAt;
  int? percentSale;
  int? numProductSold;

  Sale({
    this.saleId,
    this.productId,
    this.numProduct,
    this.startAt,
    this.endAt,
    this.percentSale,
    this.numProductSold,
  });

  Sale.fromJson(Map<String, dynamic> json) {
    saleId = json['saleId'];
    productId = json['productId'];
    numProduct = json['numProduct'];
    startAt = json['startAt'];
    endAt = json['endAt'];
    percentSale = json['percentSale'];
    numProductSold = json['numProductSold'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['saleId'] = saleId;
    data['productId'] = productId;
    data['numProduct'] = numProduct;
    data['startAt'] = startAt;
    data['endAt'] = endAt;
    data['percentSale'] = percentSale;
    data['numProductSold'] = numProductSold;
    return data;
  }
}
