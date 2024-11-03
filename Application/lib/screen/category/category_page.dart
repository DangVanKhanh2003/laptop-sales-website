import 'package:flutter/material.dart';
import 'package:shopping_app/model/category.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({
    super.key,
    required this.category,
  });

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.categoryName!),
      ),
      body: Container(),
    );
  }
}
