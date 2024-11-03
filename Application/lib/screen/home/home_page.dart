import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/provider/category_provider.dart';
import 'package:shopping_app/screen/exception/exception_page.dart';
import 'package:shopping_app/screen/home/category_grid.dart';
import 'package:shopping_app/screen/home/search_bar.dart' as search_bar;
import 'package:shopping_app/screen/home/product_view.dart';

final intializationProvider = FutureProvider((ref) async {
  await Future.delayed(const Duration(seconds: 1));
  await Future.microtask(() async {
    final category = ref.read(categoryProvider.notifier);
    if (!category.hasData) {
      await ref.read(categoryProvider.notifier).getCategory();
    }
  });
});

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late TextEditingController _controller;
  late ScrollController _scrollController;

  @override
  void initState() {
    _controller = TextEditingController();
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final initWatch = ref.watch(intializationProvider);
    final category = ref.read(categoryProvider.notifier);
    return initWatch.when(
      data: (data) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                search_bar.SearchBar(
                  controller: _controller,
                ),
                const SizedBox(height: 10.0),
                Text(
                  'Danh mục',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 5.0),
                CategoryGrid(categoryList: category.category!),
                const SizedBox(height: 10.0),
                Text(
                  'Sản phẩm',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 5.0),
                ProductView(controller: _scrollController),
              ],
            ),
          ),
        );
      },
      error: (error, _) => ExceptionPage(message: error.toString()),
      loading: () => const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
