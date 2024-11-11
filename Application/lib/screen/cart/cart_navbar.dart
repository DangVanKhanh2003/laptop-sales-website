import 'package:flutter/material.dart';
import 'package:shopping_app/model/cart.dart';

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

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text('Tổng cộng: ${_calculatePrice()}đ'),
        Text('Tổng số sản phẩm: ${widget.cartItems.length}'),
        ElevatedButton(
          style: ElevatedButton.styleFrom(),
          onPressed: () {},
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
