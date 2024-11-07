class Address {
  int? addressId;
  String? province;
  String? district;
  String? commune;
  String? street;
  String? numberHouse;

  Address({
    this.addressId,
    this.province,
    this.district,
    this.commune,
    this.street,
    this.numberHouse,
  });

  Address.fromJson(Map<String, dynamic> json) {
    addressId = json['addressId'];
    province = json['province'];
    district = json['district'];
    commune = json['commune'];
    street = json['street'];
    numberHouse = json['numberHouse'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['addressId'] = addressId;
    data['province'] = province;
    data['district'] = district;
    data['commune'] = commune;
    data['street'] = street;
    data['numberHouse'] = numberHouse;
    return data;
  }
}
