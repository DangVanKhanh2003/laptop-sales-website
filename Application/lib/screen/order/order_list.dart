import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/model/order.dart';
import 'package:shopping_app/model/product.dart';
import 'package:shopping_app/provider/token_provider.dart';
import 'package:shopping_app/repository/product_repository.dart';
import 'package:shopping_app/screen/product_detail/product_detail.dart';
import 'package:shopping_app/service/convert_helper.dart';
import 'package:shopping_app/service/getit_helper.dart';

class OrderList extends StatelessWidget {
  final List<Order> data;

  const OrderList({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: data.asMap().entries.map((entry) {
          return OrderCard(order: entry.value, orderIndex: entry.key + 1);
        }).toList(),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final Order order;
  final int orderIndex;

  const OrderCard({
    super.key,
    required this.order,
    required this.orderIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Text('$orderIndex'),
        title: Column(
          children: order.listProductOrder!.map((e) {
            return ProductItem(order: e);
          }).toList(),
        ),
      ),
    );
  }
}

class ProductItem extends ConsumerStatefulWidget {
  final ListProductOrder order;

  const ProductItem({
    super.key,
    required this.order,
  });

  @override
  ConsumerState<ProductItem> createState() => _ProductItem();
}

class _ProductItem extends ConsumerState<ProductItem> {
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

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: widget.order.product!.mainImg != null
          ? Image(
              image: MemoryImage(
                ConvertHelper.decodeBase64(
                  data: widget.order.product!.mainImg!,
                ),
              ),
              width: 100,
              height: 100,
            )
          : CachedNetworkImage(
              imageUrl: 'http://via.placeholder.com/350x150',
              fit: BoxFit.cover,
              width: 100,
              height: 100,
            ),
      title: Text(widget.order.product!.productName!),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Giá: \$${widget.order.product!.price}'),
        ],
      ),
      trailing: Tooltip(
        message: 'Xem chi tiết',
        child: _isLoading
            ? const CircularProgressIndicator.adaptive()
            : IconButton(
                onPressed: () => _viewProductDetails(
                  widget.order.product!.productId!,
                ),
                icon: const Icon(Icons.info),
              ),
      ),
    );
  }

  Future<void> _viewProductDetails(
    int productId,
  ) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final product = await GetItHelper.get<ProductRepository>()
          .getProductById(id: productId, token: ref.read(tokenProvider));
      _navigateToProductDetail(product);
    } catch (e) {
      _showError(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _navigateToProductDetail(
    Product product,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProductDetail(product: product),
      ),
    );
  }

  void _showError(String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
        'Lỗi xảy ra: $errorMessage',
      )),
    );
  }

  void _showSuccess(
    String message,
  ) async {
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
}