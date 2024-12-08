import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:shopping_app/model/cart.dart';
import 'package:shopping_app/model/product.dart';
import 'package:shopping_app/provider/token_provider.dart';
import 'package:shopping_app/repository/cart_repository.dart';
import 'package:shopping_app/screen/cart/cart_page.dart';
import 'package:shopping_app/screen/product_detail/product_detail.dart';
import 'package:shopping_app/service/convert_helper.dart';
import 'package:shopping_app/service/getit_helper.dart';

class ProductCard extends ConsumerStatefulWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  ConsumerState<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends ConsumerState<ProductCard> {
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
        content: Text('Đã thêm thành công sản phẩm ${widget.product.productName} vào giỏ hàng!'),
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
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Card(
        clipBehavior: Clip.hardEdge,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProductDetail(product: widget.product),
              ),
            );
          },
          child: ListTile(
            contentPadding: const EdgeInsets.all(8.0),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: widget.product.mainImg != null
                  ? Image(
                      image: MemoryImage(
                        ConvertHelper.decodeBase64(data: widget.product.mainImg!),
                      ),
                      height: 150,
                      width: 100,
                    )
                  : CachedNetworkImage(
                      imageUrl: 'http://via.placeholder.com/350x150',
                      width: 100,
                      height: 150,
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
            ),
            title: Text(
              widget.product.productName!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              '\$${widget.product.price!}',
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: Tooltip(
              message: 'Thêm vào giỏ hàng',
              child: IconButton(
                icon: _isLoading ? const CircularProgressIndicator.adaptive() : const Icon(Symbols.shopping_cart),
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
            ),
          ),
        ),
      ),
    );
  }
}
