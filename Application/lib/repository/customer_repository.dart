import 'package:shopping_app/api/customer_api.dart';
import 'package:shopping_app/model/customer_info.dart';
import 'package:shopping_app/model/token_state.dart';

class CustomerRepository {
  final CustomerApi _customerApi;

  CustomerRepository(this._customerApi);

  Future<dynamic> register({
    required String email,
    required String password,
  }) async {
    return await _customerApi.register(email: email, password: password);
  }

  Future<TokenState> login({
    required String email,
    required String password,
  }) async {
    return await _customerApi.login(email: email, password: password);
  }

  Future<CustomerInfo> getCustomerInfoById({
    required int customerId,
    required TokenState token,
  }) async {
    return await _customerApi.getCustomerInfoById(
      customerId: customerId,
      token: token,
    );
  }
}
