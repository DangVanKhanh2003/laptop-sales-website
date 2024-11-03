import 'package:flutter/material.dart';
import 'package:material_symbols_icons/get.dart';
import 'package:shopping_app/model/category.dart';
import 'package:shopping_app/screen/category/category_page.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.category,
  });

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Tooltip(
        message: category.categoryName!,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CategoryPage(
                    category: category,
                  ),
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  SymbolsGet.get(
                    category.categoryIcon!,
                    SymbolStyle.outlined,
                  ),
                  size: 40,
                ),
                const SizedBox(height: 8.0),
                Text(
                  category.categoryName!,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
