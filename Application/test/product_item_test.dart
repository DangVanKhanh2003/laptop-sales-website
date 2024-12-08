import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/model/product.dart';

class MockCachedNetworkImage extends StatelessWidget {
  final String imageUrl;

  const MockCachedNetworkImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: const Text('Image Loaded'),
    );
  }
}

class ProductItemWithMockedImage extends StatelessWidget {
  final Product product;
  final void Function() onTap;

  const ProductItemWithMockedImage({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MockCachedNetworkImage(
                  imageUrl: product.mainImg ?? 'placeholder'),
              const SizedBox(height: 25.0),
              Text(
                product.productName!,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 2.0),
              Text('\$${product.price!}'),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  group('Kiểm thử giao diện sản phẩm', () {
    testWidgets('Hiển thị giao diện sản phẩm chính xác',
        (WidgetTester tester) async {
      final testProduct = Product(
        productName: 'Test Product',
        price: 19.99,
        mainImg: 'http://example.com/test.png',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductItemWithMockedImage(
              product: testProduct,
              onTap: () {},
            ),
          ),
        ),
      );
      expect(find.text('Test Product'), findsOneWidget);
      expect(find.text('\$19.99'), findsOneWidget);
      expect(find.text('Image Loaded'), findsOneWidget);
    });

    testWidgets('Kiểm thử hàm onTap', (WidgetTester tester) async {
      final testProduct = Product(
        productName: 'Test Product',
        price: 19.99,
        mainImg: 'http://example.com/test.png',
      );
      var tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductItemWithMockedImage(
              product: testProduct,
              onTap: () {
                tapped = true;
              },
            ),
          ),
        ),
      );
      await tester.tap(find.byType(InkWell));
      await tester.pumpAndSettle();
      expect(tapped, isTrue);
    });
  });
}
