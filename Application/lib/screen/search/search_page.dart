import 'package:flutter/material.dart';
import 'package:shopping_app/model/product.dart';
import 'package:shopping_app/repository/product_repository.dart';
import 'package:shopping_app/screen/exception/exception_page.dart';
import 'package:shopping_app/screen/product/product_grid.dart';
import 'package:shopping_app/screen/search/empty_page.dart';
import 'package:shopping_app/service/getit.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    super.key,
    required this.name,
  });

  final String name;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
    return GetItWrapper.getIt<ProductRepository>().getProductByName(name: name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _textController,
          decoration: InputDecoration(
            suffixIcon: InkWell(
              onTap: () {
                _onSearch(_textController.text);
              },
              child: const Icon(Icons.search_outlined),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1.0,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white.withOpacity(0.95)
                    : Colors.black.withOpacity(0.95),
              ),
              borderRadius: BorderRadius.circular(18.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1.0,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white.withOpacity(0.95)
                    : Colors.black.withOpacity(0.95),
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            hintText: 'Nhập tên sản phẩm bạn muốn tìm...',
          ),
        ),
      ),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: ExceptionPage(message: snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            final data = snapshot.data!.productList!;
            if (data.isEmpty) {
              return const EmptyPage();
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: ProductGrid(
                  products: data,
                ),
              ),
            );
          } else {
            return const Center(
              child: ExceptionPage(message: 'Lỗi xảy ra'),
            );
          }
        },
      ),
    );
  }
}
