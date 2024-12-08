import 'package:shopping_app/api/order_pending_api.dart';
import 'package:shopping_app/model/order_pending.dart';
import 'package:shopping_app/model/token_state.dart';

class OrderPendingRepository {
  final OrderPendingApi _orderPendingApi;

  OrderPendingRepository(this._orderPendingApi);

  Future<List<OrderPending>> getAllOrderPending({
    required TokenState token,
    String status = 'pending',
  }) async {
    return await _orderPendingApi.getAllOrderPending(
      token: token,
      status: status,
    );
  }

  Future<void> cancelOrderPending({
    required TokenState token,
    required int orderId,
  }) async {
    return await _orderPendingApi.cancelOrderPending(
      token: token,
      orderId: orderId,
    );
  }

  Future<bool> addOrderPending({
    required TokenState token,
    required OrderPending order,
  }) async {
    return await _orderPendingApi.addOrderPending(
      token: token,
      order: order,
    );
  }
}
