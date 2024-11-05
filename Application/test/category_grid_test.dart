import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/model/category.dart';
import 'package:shopping_app/screen/home/category_grid.dart';
import 'package:shopping_app/screen/home/category_item.dart';

void main() {
  group('Kiểm thử giao diện danh mục', () {
    testWidgets('Hiển thị số lượng danh mục đúng', (WidgetTester tester) async {
      final categoryList = [
        Category(categoryId: 1, categoryName: 'Điện tử', categoryIcon: 'phone'),
        Category(categoryId: 2, categoryName: 'Quần áo', categoryIcon: 'phone'),
        Category(categoryId: 3, categoryName: 'Sách', categoryIcon: 'phone'),
      ];
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategoryGrid(categoryList: categoryList),
          ),
        ),
      );
      await tester.pump();
      expect(find.byType(CategoryItem), findsNWidgets(categoryList.length));
    });

    testWidgets('Không hiển thị khi không có danh mục',
        (WidgetTester tester) async {
      final categoryList = <Category>[];
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategoryGrid(categoryList: categoryList),
          ),
        ),
      );
      expect(find.byType(CategoryItem), findsNothing);
    });

    testWidgets('Hiển thị chính xác danh mục', (WidgetTester tester) async {
      final categoryList = [
        Category(categoryId: 1, categoryName: 'Điện tử', categoryIcon: 'phone'),
        Category(categoryId: 2, categoryName: 'Quần áo', categoryIcon: 'phone'),
        Category(categoryId: 3, categoryName: 'Sách', categoryIcon: 'phone'),
      ];
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategoryGrid(categoryList: categoryList),
          ),
        ),
      );
      await tester.pump();
      for (var category in categoryList) {
        expect(find.text(category.categoryName!), findsOneWidget);
      }
    });
  });
}
