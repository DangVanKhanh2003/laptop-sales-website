import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:shopping_app/model/cart.dart';
import 'package:shopping_app/model/payment.dart';
import 'package:shopping_app/model/product.dart';
import 'package:shopping_app/provider/token_provider.dart';
import 'package:shopping_app/repository/cart_repository.dart';
import 'package:shopping_app/screen/cart/cart_page.dart';
import 'package:shopping_app/screen/message/message_page.dart';
import 'package:shopping_app/screen/payment/payment_page.dart';
import 'package:shopping_app/service/getit_helper.dart';

class ProductNavbar extends ConsumerStatefulWidget {
  final Product product;

  const ProductNavbar({
    super.key,
    required this.product,
  });

  @override
  ConsumerState<ProductNavbar> createState() => _ProductNavbarState();
}

class _ProductNavbarState extends ConsumerState<ProductNavbar> {
  bool _isLoading = false;

  Future<void> _showError(String message, String stack) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Lỗi xảy ra'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Text(message),
              Text(stack),
            ],
          ),
        ),
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

  Future<void> _showSuccess() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Thêm sản phẩm thành công'),
        content: Text(
            'Đã thêm thành công sản phẩm ${widget.product.productName} vào giỏ hàng!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CartPage(),
                ),
              );
            },
            child: const Text('Đến giỏ hàng'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          tooltip: 'Chat với người bán',
          icon: const Icon(Symbols.message),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const MessagePage(),
              ),
            );
          },
        ),
        const SizedBox(width: 12),
        IconButton(
          tooltip: 'Thêm vào giỏ hàng',
          icon: _isLoading
              ? const CircularProgressIndicator.adaptive()
              : const Icon(Symbols.shopping_cart),
          onPressed: () async {
            setState(() {
              _isLoading = true;
            });
            try {
              await GetItHelper.get<CartRepository>().addItem(
                token: ref.read(tokenProvider),
                cart: Cart(
                  customerId: ref.read(tokenProvider.notifier).customerId,
                  amount: 1,
                  colorId: 1,
                  productId: widget.product.productId,
                ),
              );
              await _showSuccess();
            } catch (ex, s) {
              await _showError(ex.toString(), s.toString());
            } finally {
              setState(() {
                _isLoading = false;
              });
            }
          },
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: () async {
              navigatePayment() => {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PaymentPage(
                          data: [
                            Payment(
                              productId: widget.product.productId!,
                              productName: widget.product.productName!,
                              amount: 1,
                              price: widget.product.price!,
                            )
                          ],
                          money: widget.product.price!,
                        ),
                      ),
                    )
                  };
              try {
                await GetItHelper.get<CartRepository>().addItem(
                  token: ref.read(tokenProvider),
                  cart: Cart(
                    customerId: ref.read(tokenProvider.notifier).customerId,
                    amount: 1,
                    colorId: 1,
                    productId: widget.product.productId,
                  ),
                );
                navigatePayment();
              } catch (e, s) {
                _showError(e.toString(), s.toString());
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).brightness == Brightness.dark
                  ? Theme.of(context).colorScheme.secondary.withOpacity(0.50)
                  : Colors.pink[50],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Mua ngay',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '\$${widget.product.price!}',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
