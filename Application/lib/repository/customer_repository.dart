import 'package:shopping_app/api/customer_api.dart';
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
}
