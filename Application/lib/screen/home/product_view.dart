import 'package:flutter/material.dart';
import 'package:shopping_app/model/product.dart';
import 'package:shopping_app/repository/product_repository.dart';
import 'package:shopping_app/screen/product_detail/product_detail.dart';
import 'package:shopping_app/service/getit.dart';
import 'package:shopping_app/screen/exception/exception_page.dart';
import 'package:shopping_app/screen/home/product_item.dart';

class ProductView extends StatefulWidget {
  const ProductView({
    super.key,
    required this.controller,
  });

  final ScrollController controller;

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  late Future<ProductList> _productList;
  int _page = 1;
  bool _hasProduct = true;
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    _productList = GetItWrapper.getIt<ProductRepository>().getProduct(
      page: _page,
    );
    widget.controller.addListener(_scrollListener);
  }

  void _scrollListener() async {
    if (!_hasProduct) return;
    if (widget.controller.position.pixels ==
        widget.controller.position.maxScrollExtent) {
      _page++;
      final result = await GetItWrapper.getIt<ProductRepository>().getProduct(
        page: _page,
      );
      if (result.productList!.isEmpty) {
        _hasProduct = false;
        return;
      }
      setState(() {
        products.addAll(result.productList!);
      });
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _productList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (snapshot.hasData) {
          if (products.isEmpty) {
            products = snapshot.data!.productList!;
          }
          return GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            children: List.generate(
              products.length,
              (index) => Hero(
                tag: products[index].productId!,
                child: ProductItem(
                  product: products[index],
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductDetail(
                          product: products[index],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return ExceptionPage(message: snapshot.error.toString());
        } else {
          return const Center(
            child: Text('Không có sản phẩm để fetch'),
          );
        }
      },
    );
  }
}
