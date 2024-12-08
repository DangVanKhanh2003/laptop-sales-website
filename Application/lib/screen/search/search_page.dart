import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/model/product.dart';
import 'package:shopping_app/provider/token_provider.dart';
import 'package:shopping_app/repository/product_repository.dart';
import 'package:shopping_app/screen/exception/exception_page.dart';
import 'package:shopping_app/screen/product/product_grid.dart';
import 'package:shopping_app/screen/search/empty_page.dart';
import 'package:shopping_app/screen/search/search_loading.dart';
import 'package:shopping_app/service/getit_helper.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({
    super.key,
    required this.name,
  });

  final String name;

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  late Future<ProductList> _future;

  late TextEditingController _textController;

  @override
  void initState() {
    _textController = TextEditingController(text: widget.name);
    _future = _fetchProducts(widget.name);
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _onSearch(String query) {
    setState(() {
      _future = _fetchProducts(query);
    });
  }

  Future<ProductList> _fetchProducts(String name) {
    return GetItHelper.get<ProductRepository>().getProductByName(
      name: name,
      token: ref.read(tokenProvider),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black
            : Colors.white,
        title: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 12.0,
          ),
          child: TextField(
            controller: _textController,
            onSubmitted: _onSearch,
            decoration: InputDecoration(
              hintText: 'Nhập tên sản phẩm...',
              suffixIcon: InkWell(
                onTap: () {
                  _onSearch(_textController.text);
                },
                child: const Icon(Icons.search_outlined),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<ProductList>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SearchLoading();
            } else if (snapshot.hasError) {
              return Center(
                child: ExceptionPage(message: snapshot.error.toString()),
              );
            } else if (snapshot.hasData) {
              final data = snapshot.data!.productList!;
              if (data.isEmpty) {
                return const EmptyPage();
              }
              return Column(
                children: [
                  Expanded(
                    child: ProductGrid(
                      products: data,
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: ExceptionPage(message: 'Lỗi xảy ra'),
              );
            }
          },
        ),
      ),
    );
  }
}
