import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:shopping_app/model/cart.dart';
import 'package:shopping_app/model/product.dart';
import 'package:shopping_app/provider/token_provider.dart';
import 'package:shopping_app/repository/cart_repository.dart';
import 'package:shopping_app/repository/product_repository.dart';
import 'package:shopping_app/screen/cart/empty_cart.dart';
import 'package:shopping_app/screen/product_detail/product_detail.dart';
import 'package:shopping_app/service/getit_helper.dart';

class CartView extends ConsumerStatefulWidget {
  const CartView({
    super.key,
    required this.items,
  });

  final List<CartItem> items;

  @override
  ConsumerState<CartView> createState() => _CartViewState();
}

class _CartViewState extends ConsumerState<CartView> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void _navigateProductDetail(Product product) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProductDetail(product: product),
      ),
    );
  }

  Future<void> _showError(String message) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Lỗi xảy ra'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _showSuccess(String message) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Thành công'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _deleteProduct({
    required CartItem cart,
  }) async {
    try {
      await GetItHelper.get<CartRepository>().deleteItem(
        token: ref.read(tokenProvider),
        cart: cart,
      );
      _showSuccess('Đã xoá thành công ${cart.productName} khỏi giỏ hàng');
      setState(() {
        widget.items.remove(cart);
      });
    } catch (e) {
      _showError(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) {
      return const EmptyCart();
    }
    return SingleChildScrollView(
      child: Column(
        children: widget.items
            .map(
              (e) => Card(
                child: ListTile(
                  leading: CachedNetworkImage(
                    imageUrl: e.mainImg ?? 'http://via.placeholder.com/350x150',
                    width: 40,
                    height: 40,
                  ),
                  title: Text(e.productName!),
                  subtitle: Text('Số lượng: ${e.amount}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Tooltip(
                        message: 'Xem chi tiết',
                        child: IconButton(
                          onPressed: _isLoading
                              ? null
                              : () async {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  try {
                                    final product = await GetItHelper.get<
                                            ProductRepository>()
                                        .getProductById(
                                      id: e.productId!,
                                      token: ref.read(tokenProvider),
                                    );
                                    _navigateProductDetail(product);
                                  } catch (e) {
                                    _showError(e.toString());
                                  } finally {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  }
                                },
                          icon: _isLoading
                              ? const CircularProgressIndicator.adaptive()
                              : const Icon(
                                  Symbols.info,
                                  color: Colors.cyan,
                                ),
                        ),
                      ),
                      Tooltip(
                        message: 'Xoá sản phẩm',
                        child: IconButton(
                          onPressed: () => _deleteProduct(cart: e),
                          icon: const Icon(
                            Symbols.delete,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
