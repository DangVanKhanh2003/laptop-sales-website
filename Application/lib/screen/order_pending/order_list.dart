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
  const OrderList({
    super.key,
    required this.data,
    required this.onRefreshFuture,
  });
  final List<OrderPending> data;
  final void Function() onRefreshFuture;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: data.asMap().entries.map((entry) {
          return OrderCard(
            order: entry.value,
            orderIndex: entry.key + 1,
            onRefreshFuture: onRefreshFuture,
          );
        }).toList(),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final OrderPending order;
  final int orderIndex;
  final void Function() onRefreshFuture;

  const OrderCard({
    super.key,
    required this.order,
    required this.orderIndex,
    required this.onRefreshFuture,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Text('$orderIndex'),
        title: Column(
          children: order.listProductOrederPending!.map((e) {
            return ProductItem(
              product: e,
              onRefreshFuture: onRefreshFuture,
            );
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
    required this.onRefreshFuture,
  });
  final void Function() onRefreshFuture;

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
    final isMobile = MediaQuery.of(context).size.width < 600;

    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: isMobile ? 8.0 : 16.0,
        vertical: isMobile ? 4.0 : 8.0,
      ),
      leading: widget.product.mainImg != null
          ? Image(
              image: MemoryImage(
                ConvertHelper.decodeBase64(data: widget.product.mainImg!),
              ),
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            )
          : CachedNetworkImage(
              imageUrl: 'http://via.placeholder.com/350x150',
              fit: BoxFit.cover,
              width: 80,
              height: 80,
            ),
      title: Text(
        widget.product.productName!,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: isMobile ? 14 : 16),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Giá: \$${widget.product.price}',
            style: TextStyle(fontSize: isMobile ? 12 : 14),
          ),
          const SizedBox(height: 4.0),
          Text(
            'Số lượng: ${widget.product.amount}',
            style: TextStyle(fontSize: isMobile ? 12 : 14),
          ),
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
                    icon: Icon(
                      Symbols.info,
                      size: isMobile ? 18 : 24,
                    ),
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
                    icon: Icon(
                      Symbols.remove,
                      color: Colors.red,
                      size: isMobile ? 18 : 24,
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
    final state = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('Xác nhận hủy'),
        content: Text('Bạn có muốn hủy đơn hàng không?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text('Có'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text('Không'),
          ),
        ],
      ),
    );
    try {
      if (state) {
        setState(() {
          _isLoading = true;
        });
        await GetItHelper.get<OrderPendingRepository>().cancelOrderPending(
          token: ref.read(tokenProvider),
          orderId: orderId,
        );

        _showSuccess('Đã xoá đơn hàng!');
      }
    } catch (e) {
      _showError(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
      widget.onRefreshFuture();
    }
  }

  Future<void> _viewProductDetails(
    int productId,
  ) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final product =
          await GetItHelper.get<ProductRepository>().getProductById(id: productId, token: ref.read(tokenProvider));
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
