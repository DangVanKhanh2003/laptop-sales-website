import 'package:admin/api/customer_api.dart';
import 'package:admin/model/customer_info.dart';

class CustomerRepository {
  final CustomerApi _customerApi;

  CustomerRepository(this._customerApi);

  Future<List<CustomerAccount>> getAllCustomer() async {
    return await _customerApi.getAllCustomer();
  }

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

  Future<void> updateCustomerPassword({
    required String email,
    required String password,
  }) async {
    return await _customerApi.updateCustomerPassword(
      email: email,
      password: password,
    );
  }

  Future<void> register({
    required String email,
    required String password,
  }) async {
    return await _customerApi.register(
      email: email,
      password: password,
    );
  }

  Future<void> deleteCustomer({
    required String guid,
  }) async {
    return await _customerApi.deleteCustomer(
      guid: guid,
    );
  }
}
