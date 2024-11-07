import 'package:shopping_app/model/address.dart';

class CustomerInfo {
  int? customerId;
  String? fullName;
  String? phoneNumber;
  Address? address;

  CustomerInfo({
    this.customerId,
    this.fullName,
    this.phoneNumber,
    this.address,
  });

  CustomerInfo.fromJson(Map<String, dynamic> json) {
    customerId = json['customerId'];
    fullName = json['fullName'];
    phoneNumber = json['phoneNumber'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customerId'] = customerId;
    data['fullName'] = fullName;
    data['phoneNumber'] = phoneNumber;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    return data;
  }
}
