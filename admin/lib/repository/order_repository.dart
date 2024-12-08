import 'package:admin/api/order_api.dart';
import 'package:admin/model/order.dart';

class OrderRepository {
  final OrderApi _orderApi;

  OrderRepository(this._orderApi);

  Future<List<Order>> getAllOrders({
    required String status,
  }) async {
    return await _orderApi.getAllOrders(
      status: status,
    );
  }

  Future<void> cancelOrder({
    required int orderId,
  }) async {
    return await _orderApi.cancelOrder(
      orderId: orderId,
    );
  }

  Future<void> approveOrder({
    required int orderId,
  }) async {
    return await _orderApi.approveOrder(
      orderId: orderId,
    );
  }
}
