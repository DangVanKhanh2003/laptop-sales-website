import 'package:flutter/material.dart';

class CartNavbar extends StatefulWidget {
  const CartNavbar({super.key});

  final double price = 100000;

  @override
  State<CartNavbar> createState() => _CartNavbarState();
}

class _CartNavbarState extends State<CartNavbar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text('Tổng cộng: ${widget.price}đ'),
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
