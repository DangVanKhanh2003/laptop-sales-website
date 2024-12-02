import 'package:admin/api/customer_api.dart';
import 'package:admin/model/customer_info.dart';

class CustomerRepository {
  final CustomerApi _customerApi;

  CustomerRepository(this._customerApi);

  Future<CustomerInfo> getCustomerInfoById({
    required int customerId,
  }) async {
    return await _customerApi.getCustomerInfoById(
      customerId: customerId,
    );
  }

  Future<CustomerInfo> updateCustomerInfo({
    required CustomerInfo customerInfo,
  }) async {
    return await _customerApi.updateCustomerInfo(
      customerInfo: customerInfo,
    );
  }

  Future<CustomerInfo> updateCustomerPassword({
    required String email,
    required String oldPassword,
    required String newPassword,
  }) async {
    return await _customerApi.updateCustomerPassword(
      email: email,
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
  }
}
