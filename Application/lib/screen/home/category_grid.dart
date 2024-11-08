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
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 1.0,
      ),
      itemCount: categoryList.length,
      itemBuilder: (context, index) {
        final category = categoryList[index];
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: CategoryItem(category: category),
        );
      },
    );
  }
}
