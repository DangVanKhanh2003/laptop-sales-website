import 'package:shopping_app/model/address.dart';

class Store {
  int? storeId;
  String? storeName;
  Address? address;

  Store({
    this.storeId,
    this.storeName,
    this.address,
  });

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
