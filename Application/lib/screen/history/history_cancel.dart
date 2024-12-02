import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/model/history.dart' as model;
import 'package:shopping_app/provider/token_provider.dart';
import 'package:shopping_app/repository/history_repository.dart';
import 'package:shopping_app/screen/exception/exception_page.dart';
import 'package:shopping_app/screen/history/history_empty.dart';
import 'package:shopping_app/service/convert_helper.dart';
import 'package:shopping_app/service/getit_helper.dart';

class HistoryCancel extends ConsumerStatefulWidget {
  const HistoryCancel({super.key});

  @override
  ConsumerState<HistoryCancel> createState() => _HistoryCancelState();
}

class _HistoryCancelState extends ConsumerState<HistoryCancel> {
  late Future<List<model.HistoryCancel>> _future;

  @override
  void initState() {
    super.initState();
    _future = _fetchHistory();
  }

  Future<List<model.HistoryCancel>> _fetchHistory() {
    final token = ref.read(tokenProvider);
    final customerId = ref.read(tokenProvider.notifier).customerId;
    return GetItHelper.get<HistoryRepository>().getCancelHistory(
      token: token,
      customerId: customerId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<model.HistoryCancel>>(
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
  final List<model.HistoryCancel> data;

  const HistoryList({
    required this.data,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: data
            .asMap()
            .entries
            .map((history) => HistoryCard(
                  history: history.value,
                  index: history.key + 1,
                ))
            .toList(),
      ),
    );
  }
}

class HistoryCard extends StatelessWidget {
  final model.HistoryCancel history;
  final int index;

  const HistoryCard({
    required this.history,
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: Text('$index'),
        title: Text('${history.odertDate}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: history.cancelProducts!
              .map((productOrder) => ProductCard(productOrder: productOrder))
              .toList(),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final model.CancelProducts productOrder;

  const ProductCard({
    required this.productOrder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final product = productOrder.product!;
    final image = product.mainImg != null
        ? Image(
            image:
                MemoryImage(ConvertHelper.decodeBase64(data: product.mainImg!)),
            width: 50,
            height: 50,
          )
        : CachedNetworkImage(
            imageUrl: 'http://via.placeholder.com/350x150',
            fit: BoxFit.cover,
            width: 100,
            height: 100,
          );

    return Card(
      margin: const EdgeInsets.only(top: 8),
      child: ListTile(
        leading: image,
        title: Text(product.productName!),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Giá bán: \$${product.price}'),
            Text('Số lượng: ${productOrder.amount}'),
          ],
        ),
      ),
    );
  }
}
