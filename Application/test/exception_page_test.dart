import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/screen/exception/exception_page.dart';

void main() {
  group('Kiểm thử giao diện khi xảy ra lỗi', () {
    testWidgets('Hiện thị tin nhắn và icon đúng vị trí',
        (WidgetTester tester) async {
      const message = 'Lỗi xảy ra vui lfong thử lại';
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ExceptionPage(message: message),
          ),
        ),
      );
      expect(find.byIcon(Icons.flutter_dash_outlined), findsOneWidget);
      expect(find.byIcon(Icons.info_outline), findsOneWidget);
      expect(find.text(message), findsOneWidget);
      expect(find.text('Thử lại'), findsNothing);
    });

    testWidgets('Hiển thị nút thử lại khi có hàm onTap',
        (WidgetTester tester) async {
      const message = 'Lỗi xảy ra vui lfong thử lại';
      var retryPressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExceptionPage(
              message: message,
              onTap: () {
                retryPressed = true;
              },
            ),
          ),
        ),
      );
      expect(find.text('Thử lại'), findsOneWidget);
      await tester.tap(find.text('Thử lại'));
      await tester.pump();
      expect(retryPressed, isTrue);
    });

    testWidgets('Không hiển thị khi onTap không có giá trj',
        (WidgetTester tester) async {
      const message = 'Lỗi xảy ra vui lfong thử lại';
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ExceptionPage(
              message: message,
            ),
          ),
        ),
      );
      expect(find.text('Thử lại'), findsNothing);
    });
  });
}
