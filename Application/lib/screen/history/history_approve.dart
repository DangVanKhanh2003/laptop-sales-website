import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/model/history.dart';
import 'package:shopping_app/model/order.dart';
import 'package:shopping_app/provider/token_provider.dart';
import 'package:shopping_app/repository/history_repository.dart';
import 'package:shopping_app/screen/exception/exception_page.dart';
import 'package:shopping_app/screen/history/history_empty.dart';
import 'package:shopping_app/service/convert_helper.dart';
import 'package:shopping_app/service/getit_helper.dart';

class HistoryApprove extends ConsumerStatefulWidget {
  const HistoryApprove({super.key});

  @override
  ConsumerState<HistoryApprove> createState() => _HistoryApproveState();
}

class _HistoryApproveState extends ConsumerState<HistoryApprove> {
  late Future<List<HistorySuccess>> _future;

  @override
  void initState() {
    super.initState();
    _future = _fetchHistory();
  }

  Future<List<HistorySuccess>> _fetchHistory() {
    final token = ref.read(tokenProvider);
    final customerId = ref.read(tokenProvider.notifier).customerId;
    return GetItHelper.get<HistoryRepository>().getSuccessHistory(
      token: token,
      customerId: customerId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<HistorySuccess>>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (snapshot.hasError) {
          return Center(
            child: ExceptionPage(
              message: snapshot.error.toString(),
            ),
          );
        } else if (snapshot.hasData) {
          if (snapshot.data!.isNotEmpty) {
            return HistoryList(data: snapshot.data!);
          }
          return const HistoryEmpty();
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

class HistoryList extends StatelessWidget {
  final List<HistorySuccess> data;

  const HistoryList({
    required this.data,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: data.map((history) => HistoryCard(history: history)).toList(),
      ),
    );
  }
}

class HistoryCard extends StatelessWidget {
  final HistorySuccess history;

  const HistoryCard({required this.history, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mã đơn hàng: ${history.orderId}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Ngày xuất: ${history.dateExport}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Divider(height: 24, thickness: 1),
            Column(
              children:
                  history.listProductOrder!.map((productOrder) => ProductCard(productOrder: productOrder)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final ListProductOrder productOrder;

  const ProductCard({
    required this.productOrder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final product = productOrder.product!;
    final image = product.mainImg != null
        ? Image(
            image: MemoryImage(ConvertHelper.decodeBase64(data: product.mainImg!)),
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          )
        : CachedNetworkImage(
            imageUrl: 'http://via.placeholder.com/350x150',
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          );

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.grey[800],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: image,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.productName!,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Giá bán: ${product.price}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  'Số lượng: ${productOrder.amount}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
