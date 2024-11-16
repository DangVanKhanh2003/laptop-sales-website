import 'package:flutter/material.dart';
import 'package:shopping_app/model/cart.dart';
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tổng cộng: \$${_calculatePrice()}'),
            const SizedBox(height: 10.0),
            Text('Tổng số sản phẩm: ${_getTotalProducts()}'),
          ],
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PaymentPage(
                  cart: widget.cartItems,
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
