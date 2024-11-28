import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:shopping_app/model/order_pending.dart';
import 'package:shopping_app/model/product.dart';
import 'package:shopping_app/provider/token_provider.dart';
import 'package:shopping_app/repository/order_pending_repository.dart';
import 'package:shopping_app/repository/product_repository.dart';
import 'package:shopping_app/screen/product_detail/product_detail.dart';
import 'package:shopping_app/service/convert_helper.dart';
import 'package:shopping_app/service/getit_helper.dart';

class OrderList extends StatelessWidget {
  final List<OrderPending> data;

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
  final OrderPending order;
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
          children: order.listProductOrederPending!.map((e) {
            return ProductItem(product: e);
          }).toList(),
        ),
      ),
    );
  }
}

class ProductItem extends ConsumerStatefulWidget {
  final ListProductOrederPending product;

  const ProductItem({
    super.key,
    required this.product,
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
      leading: widget.product.mainImg != null
          ? Image(
              image: MemoryImage(
                ConvertHelper.decodeBase64(data: widget.product.mainImg!),
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
      title: Text(widget.product.productName!),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Giá: \$${widget.product.price}'),
          Text('Số lượng: ${widget.product.amount}'),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Tooltip(
            message: 'Xem chi tiết',
            child: _isLoading
                ? const CircularProgressIndicator.adaptive()
                : IconButton(
                    onPressed: () => _viewProductDetails(
                      widget.product.productId!,
                    ),
                    icon: const Icon(Symbols.info),
                  ),
          ),
          Tooltip(
            message: 'Huỷ đơn hàng',
            child: _isLoading
                ? const CircularProgressIndicator.adaptive()
                : IconButton(
                    onPressed: () => _cancelProduct(
                      widget.product.productOrderPendingId!,
                    ),
                    icon: const Icon(
                      Symbols.remove,
                      color: Colors.red,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> _cancelProduct(
    int orderId,
  ) async {
    setState(() {
      _isLoading = true;
    });
    try {
      await GetItHelper.get<OrderPendingRepository>().cancelOrderPending(
        token: ref.read(tokenProvider),
        orderId: orderId,
      );
      _showSuccess('Đã xoá đơn hàng!');
    } catch (e) {
      _showError(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
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
