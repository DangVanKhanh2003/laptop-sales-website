import 'package:shopping_app/api/cart_api.dart';
import 'package:shopping_app/model/cart.dart';
import 'package:shopping_app/model/token_state.dart';

class CartRepository {
  final CartApi _cartApi;

  CartRepository(this._cartApi);

  Future<CartList> getAllItems({
    required TokenState token,
    required int customerId,
  }) async {
    return await _cartApi.getAllItems(
      token: token,
      customerId: customerId,
    );
  }

  Future<void> addItem({
    required TokenState token,
    required Cart cart,
  }) async {
    return await _cartApi.addItem(
      token: token,
      cart: cart,
    );
  }

  Future<void> updateItem({
    required TokenState token,
    required CartItem cart,
  }) async {
    return await _cartApi.updateItem(
      token: token,
      cart: cart,
    );
  }

  Future<void> deleteItem({
    required TokenState token,
    required CartItem cart,
  }) async {
    return await _cartApi.deleteItem(
      token: token,
      cart: cart,
    );
  }
}
