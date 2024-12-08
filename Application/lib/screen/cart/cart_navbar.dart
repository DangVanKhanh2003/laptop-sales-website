import 'package:flutter/material.dart';
import 'package:shopping_app/model/cart.dart';
import 'package:shopping_app/model/payment.dart';
import 'package:shopping_app/screen/payment/payment_page.dart';

class CartNavbar extends StatefulWidget {
  const CartNavbar({
    super.key,
    required this.cartItems,
  });

  final List<CartItem> cartItems;

  @override
  State<CartNavbar> createState() => _CartNavbarState();
}

class _CartNavbarState extends State<CartNavbar> {
  double _calculatePrice() {
    var finalPrice = 0.0;
    for (var e in widget.cartItems) {
      finalPrice += (e.price! * e.amount!.toDouble());
    }
    return finalPrice;
  }

  int _getTotalProducts() {
    var result = 0;
    for (var e in widget.cartItems) {
      result += e.amount!;
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final price = _calculatePrice();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tổng cộng: \$$price'),
            const SizedBox(height: 10.0),
            Text('Tổng số sản phẩm: ${_getTotalProducts()}'),
          ],
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(),
          onPressed: price == 0
              ? null
              : () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PaymentPage(
                        data: [
                          ...widget.cartItems.map((e) => Payment(
                                productId: e.productId!,
                                productName: e.productName!,
                                amount: e.amount!,
                                price: e.price!,
                              ))
                        ],
                        money: _calculatePrice(),
                      ),
                    ),
                  );
                },
          child: const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 20.0,
            ),
            child: Text('Thanh toán'),
          ),
        ),
      ],
    );
  }
}
