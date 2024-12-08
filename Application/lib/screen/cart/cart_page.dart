import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/model/cart.dart';
import 'package:shopping_app/provider/token_provider.dart';
import 'package:shopping_app/repository/cart_repository.dart';
import 'package:shopping_app/screen/cart/cart_loading.dart';
import 'package:shopping_app/screen/cart/cart_navbar.dart';
import 'package:shopping_app/screen/cart/cart_view.dart';
import 'package:shopping_app/screen/exception/exception_page.dart';
import 'package:shopping_app/service/getit_helper.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  late Future<CartList> _future;

  late List<CartItem> _selectedItems;

  @override
  void initState() {
    super.initState();
    _selectedItems = [];
    _future = GetItHelper.get<CartRepository>().getAllItems(
      token: ref.read(tokenProvider),
      customerId: ref.read(tokenProvider.notifier).customerId,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ hàng của tôi'),
      ),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CartLoading();
          } else if (snapshot.hasData) {
            final data = snapshot.data!.items!;
            return CartView(
              items: data,
              selectedItems: _selectedItems,
              updateState: () {
                setState(() {});
              },
              onChangeSelectedItem: (CartItem cart) {
                if (_selectedItems.contains(cart)) {
                  _selectedItems.remove(cart);
                } else {
                  _selectedItems.add(cart);
                }
                setState(() {});
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: ExceptionPage(message: snapshot.error.toString()),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: CartNavbar(
          cartItems: _selectedItems,
        ),
      ),
    );
  }
}
