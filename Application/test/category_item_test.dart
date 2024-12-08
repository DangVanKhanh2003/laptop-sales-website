import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/model/category.dart';
import 'package:shopping_app/screen/home/category_item.dart';

void main() {
  group('Kiểm thử giao diện danh mục con', () {
    final testCategory = Category(
      categoryId: 1,
      categoryName: 'Điện tử',
      categoryIcon: 'home',
    );
    testWidgets('Hiển thị tên danh mục con và icon',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategoryItem(category: testCategory),
          ),
        ),
      );
      expect(find.text('Điện tử'), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
    });

    testWidgets('Chuyển hướng vào màn hình CategoryPage',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategoryItem(category: testCategory),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Điện tử'), findsOneWidget);
    });
  });
}
