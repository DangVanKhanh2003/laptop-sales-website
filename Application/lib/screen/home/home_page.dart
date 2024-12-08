import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/model/category.dart';
import 'package:shopping_app/provider/token_provider.dart';
import 'package:shopping_app/repository/category_repository.dart';
import 'package:shopping_app/screen/exception/exception_page.dart';
import 'package:shopping_app/screen/home/category_grid.dart';
import 'package:shopping_app/screen/home/home_loading.dart';
import 'package:shopping_app/screen/home/search_bar.dart' as search_bar;
import 'package:shopping_app/screen/product/product_view.dart';
import 'package:shopping_app/service/getit_helper.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late TextEditingController _controller;
  late ScrollController _scrollController;
  late Future<CategoryList> _future;

  @override
  void initState() {
    _controller = TextEditingController();
    _scrollController = ScrollController();
    _future = GetItHelper.get<CategoryRepository>().getAllCategory(
      token: ref.read(tokenProvider),
    );
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
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const HomeLoading();
        } else if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  search_bar.SearchBar(controller: _controller),
                  const SizedBox(height: 20.0),
                  Text(
                    'Danh mục',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12.0),
                  CategoryGrid(categoryList: snapshot.data!.categoryList!),
                  const SizedBox(height: 20.0),
                  Text(
                    'Sản phẩm',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12.0),
                  SizedBox(
                    height: 400,
                    child: ProductView(controller: _scrollController),
                  ),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: ExceptionPage(
              message: snapshot.error.toString(),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
