import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:shopping_app/model/cart.dart';
import 'package:shopping_app/model/product.dart';
import 'package:shopping_app/model/token_state.dart';
import 'package:shopping_app/provider/token_provider.dart';
import 'package:shopping_app/repository/cart_repository.dart';
import 'package:shopping_app/repository/product_repository.dart';
import 'package:shopping_app/screen/cart/empty_cart.dart';
import 'package:shopping_app/screen/product_detail/product_detail.dart';
import 'package:shopping_app/service/convert_helper.dart';
import 'package:shopping_app/service/getit_helper.dart';

class CartView extends ConsumerStatefulWidget {
  const CartView({
    super.key,
    required this.items,
    required this.selectedItems,
    required this.onChangeSelectedItem,
    required this.updateState,
  });

  final List<CartItem> selectedItems;

  final void Function(CartItem cart) onChangeSelectedItem;

  final List<CartItem> items;

  final void Function() updateState;

  @override
  ConsumerState<CartView> createState() => _CartViewState();
}

class _CartViewState extends ConsumerState<CartView> {
  late int amount;

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

  Future<void> _showError(String message) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Lỗi xảy ra'),
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

  Future<void> _showSuccess(String message) async {
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

  void _deleteProduct({
    required CartItem cart,
  }) async {
    try {
      await GetItHelper.get<CartRepository>().deleteItem(
        token: ref.read(tokenProvider),
        cart: cart,
      );
      _showSuccess('Đã xoá thành công ${cart.productName} khỏi giỏ hàng');
      setState(() {
        widget.items.remove(cart);
      });
    } catch (e) {
      _showError(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) {
      return const EmptyCart();
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: widget.items
              .map(
                (e) => _ProductCard(
                  cart: e,
                  onDelete: () => _deleteProduct(cart: e),
                  selectedItems: widget.selectedItems,
                  onChangeSelectedItem: widget.onChangeSelectedItem,
                  onUpdate: widget.updateState,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class _ProductCard extends ConsumerStatefulWidget {
  const _ProductCard({
    required this.cart,
    required this.onDelete,
    required this.selectedItems,
    required this.onChangeSelectedItem,
    required this.onUpdate,
  });

  final CartItem cart;
  final List<CartItem> selectedItems;
  final void Function(CartItem cart) onChangeSelectedItem;
  final void Function() onDelete;
  final void Function() onUpdate;

  @override
  ConsumerState<_ProductCard> createState() => __ProductCardState();
}

class __ProductCardState extends ConsumerState<_ProductCard> {
  bool _isLoading = false;
  late final int _originalAmount;

  late final TokenState token;

  @override
  void initState() {
    token = ref.read(tokenProvider);
    _originalAmount = widget.cart.amount!;
    super.initState();
  }

  @override
  void dispose() {
    if (widget.cart.amount != _originalAmount) {
      Future.microtask(() async {
        await GetItHelper.get<CartRepository>().updateItem(
          token: token,
          cart: widget.cart,
        );
      });
    }
    super.dispose();
  }

  void _navigateProductDetail(Product product) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProductDetail(product: product),
      ),
    );
  }

  Future<void> _showError(String message) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Lỗi xảy ra'),
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

  Future<void> _fetchProductDetail() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final product = await GetItHelper.get<ProductRepository>().getProductById(
        id: widget.cart.productId!,
        token: ref.read(tokenProvider),
      );
      _navigateProductDetail(product);
    } catch (e) {
      _showError(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: ListTile(
            contentPadding: const EdgeInsets.all(8.0),
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: widget.selectedItems.contains(widget.cart),
                  onChanged: (value) => widget.onChangeSelectedItem(widget.cart),
                ),
                const SizedBox(width: 5.0),
                widget.cart.mainImg != null
                    ? Image(
                        image: MemoryImage(ConvertHelper.decodeBase64(data: widget.cart.mainImg!)),
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )
                    : CachedNetworkImage(
                        imageUrl: 'http://via.placeholder.com/350x150',
                        width: 50,
                        height: 50,
                      ),
              ],
            ),
            title: Text(widget.cart.productName!),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _ChangeAmount(
                  amount: widget.cart.amount!,
                  onAdd: () {
                    setState(() {
                      widget.cart.amount = widget.cart.amount! + 1;
                    });
                    widget.onUpdate();
                  },
                  onMinus: () async {
                    var value = (widget.cart.amount!) - 1;
                    if (value > 0) {
                      setState(() {
                        widget.cart.amount = value;
                      });
                      widget.onUpdate();
                    } else {
                      await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Không thể chỉnh sửa sản phẩm'),
                          content: const Text('Số lượng không thể dưới 1'),
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
                  },
                ),
                Text('Giá bán: \$${widget.cart.price}'),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Tooltip(
                  message: 'Xem chi tiết',
                  child: IconButton(
                    onPressed: _isLoading ? null : _fetchProductDetail,
                    icon: _isLoading
                        ? const CircularProgressIndicator.adaptive()
                        : const Icon(
                            Symbols.info,
                            color: Colors.cyan,
                          ),
                  ),
                ),
                Tooltip(
                  message: 'Xoá sản phẩm',
                  child: IconButton(
                    onPressed: widget.onDelete,
                    icon: const Icon(
                      Symbols.delete,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 5.0),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Divider(thickness: 1.0),
        ),
        const SizedBox(height: 5.0),
      ],
    );
  }
}

class _ChangeAmount extends StatelessWidget {
  const _ChangeAmount({
    required this.onAdd,
    required this.onMinus,
    required this.amount,
  });

  final void Function() onAdd;

  final void Function() onMinus;

  final int amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Số lượng:'),
            Row(
              children: [
                IconButton(
                  onPressed: onMinus,
                  icon: const Icon(
                    Symbols.remove,
                  ),
                ),
                const SizedBox(width: 5.0),
                Text('$amount'),
                const SizedBox(width: 5.0),
                IconButton(
                  onPressed: onAdd,
                  icon: const Icon(Symbols.add),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
