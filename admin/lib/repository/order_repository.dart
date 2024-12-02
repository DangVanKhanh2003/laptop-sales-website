import 'package:admin/api/order_api.dart';
import 'package:admin/model/order.dart';

class OrderRepository {
  final OrderApi _orderApi;

  OrderRepository(this._orderApi);

  Future<List<Order>> getAllOrders({
    required int customerId,
  }) async {
    return await _orderApi.getAllOrders(
      customerId: customerId,
    );
  }
}
