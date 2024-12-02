class Account {
  String? accCustomerId;
  int? customerId;
  String? email;

  Account({this.accCustomerId, this.customerId, this.email});

  Account.fromJson(Map<String, dynamic> json) {
    accCustomerId = json['accCustomerId'];
    customerId = json['customerId'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accCustomerId'] = accCustomerId;
    data['customerId'] = customerId;
    data['email'] = email;
    return data;
  }
}
