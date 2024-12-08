import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/provider/setting_provider.dart';
import 'package:shopping_app/screen/home/search_bar.dart' as search_bar;

void main() {
  group('Kiểm thử chức năng tìm kiếm', () {
    testWidgets('Thanh công cụ tìm kiếm hiển thị đúng ô dữ liệu người dùng',
        (WidgetTester tester) async {
      final TextEditingController controller = TextEditingController();
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: search_bar.SearchBar(controller: controller),
            ),
          ),
        ),
      );
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byIcon(Icons.search_outlined), findsOneWidget);
      expect(find.text('Nhập tên sản phẩm bạn muốn tìm...'), findsOneWidget);
      controller.text = 'abc';
      await tester.pump();
      expect(find.text('abc'), findsOneWidget);
    });

    testWidgets('Thay đổi giao diện', (WidgetTester tester) async {
      final themeProvider =
          StateNotifierProvider<SettingProvider, SettingState>(
        (ref) => SettingProvider(),
      );
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            themeProvider,
          ],
          child: MaterialApp(
            home: Scaffold(
              body: search_bar.SearchBar(controller: TextEditingController()),
            ),
          ),
        ),
      );
      expect(
          find.byWidgetPredicate((widget) =>
              widget is TextField &&
              widget.decoration?.enabledBorder?.borderSide.color ==
                  Colors.black.withOpacity(0.95)),
          findsOneWidget);
      await tester.pump();
    });
  });
}
