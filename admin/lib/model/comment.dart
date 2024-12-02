import 'package:admin/model/address.dart';

class Comment {
  int? commentId;
  Customer? customer;
  int? productId;
  String? commentDetail;
  String? commentDate;
  int? parentId;
  int? toCustomer;
  List<String>? subComments;

  Comment({
    this.commentId,
    this.customer,
    this.productId,
    this.commentDetail,
    this.commentDate,
    this.parentId,
    this.toCustomer,
    this.subComments,
  });

  Comment.fromJson(Map<String, dynamic> json) {
    commentId = json['commentId'];
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    productId = json['productId'];
    commentDetail = json['commentDetail'];
    commentDate = json['commentDate'];
    parentId = json['parentId'];
    toCustomer = json['toCustomer'];
    if (json['subComments'] != null) {
      subComments = <String>[];
      json['subComments'].forEach((v) {
        subComments!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['commentId'] = commentId;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    data['productId'] = productId;
    data['commentDetail'] = commentDetail;
    data['commentDate'] = commentDate;
    data['parentId'] = parentId;
    data['toCustomer'] = toCustomer;
    if (subComments != null) {
      data['subComments'] = subComments;
    }
    return data;
  }
}

class Customer {
  int? customerId;
  String? fullName;
  String? phoneNumber;
  Address? address;

  Customer({
    this.customerId,
    this.fullName,
    this.phoneNumber,
    this.address,
  });

  Customer.fromJson(Map<String, dynamic> json) {
    customerId = json['customerId'];
    fullName = json['fullName'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customerId'] = customerId;
    data['fullName'] = fullName;
    data['phoneNumber'] = phoneNumber;
    data['address'] = address;
    return data;
  }
}
