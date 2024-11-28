import 'package:shopping_app/api/order_api.dart';
import 'package:shopping_app/model/order.dart';
import 'package:shopping_app/model/token_state.dart';

class OrderRepository {
  final OrderApi _orderApi;

  OrderRepository(this._orderApi);

  Future<List<Order>> getAllOrders({
    required TokenState token,
    required int customerId,
  }) async {
    return await _orderApi.getAllOrders(
      token: token,
      customerId: customerId,
    );
  }
}
