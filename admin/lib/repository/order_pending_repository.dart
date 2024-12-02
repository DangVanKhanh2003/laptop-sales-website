import 'package:admin/api/order_pending_api.dart';
import 'package:admin/model/order_pending.dart';

class OrderPendingRepository {
  final OrderPendingApi _orderPendingApi;

  OrderPendingRepository(this._orderPendingApi);

  Future<List<OrderPending>> getAllOrderPending({
    String status = 'pending',
  }) async {
    return await _orderPendingApi.getAllOrderPending(
      status: status,
    );
  }

  Future<void> cancelOrderPending({
    required int orderId,
  }) async {
    return await _orderPendingApi.cancelOrderPending(
      orderId: orderId,
    );
  }

  Future<bool> addOrderPending({
    required OrderPending order,
  }) async {
    return await _orderPendingApi.addOrderPending(
      order: order,
    );
  }
}
