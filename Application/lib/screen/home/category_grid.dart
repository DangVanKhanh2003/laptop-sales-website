import 'package:flutter/material.dart';
import 'package:shopping_app/model/category.dart';
import 'package:shopping_app/screen/home/category_item.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({
    super.key,
    required this.categoryList,
  });

  final List<Category> categoryList;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      children: List.generate(
        categoryList.length,
        (index) {
          final e = categoryList[index];
          return CategoryItem(category: e);
        },
      ),
    );
  }
}
