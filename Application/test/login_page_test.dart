import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/screen/login/login_page.dart';
import 'package:shopping_app/screen/register/register_page.dart';

void main() {
  group('Kiểm thử chức năng đăng nhập', () {
    testWidgets('Hiển thị giao diện đăng nhập', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginPage()));

      expect(find.text('Đăng nhập'), findsOneWidget);
    });

    testWidgets('Hiển thị email và mật khẩu', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginPage()));

      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.text('Địa chỉ email'), findsOneWidget);
      expect(find.text('Mật khẩu'), findsOneWidget);
    });

    testWidgets('Hiển thị nút đăng nhập và thử nút đăng nhập',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginPage()));

      final loginButton = find.text('Đăng nhập');
      expect(loginButton, findsOneWidget);

      await tester.tap(loginButton);
      await tester.pump();
    });

    testWidgets('Điều hướng vào màn hình đăng ký khi nhấn "Đăng ký ngay!"',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginPage()));

      final registerLink = find.text('Bạn chưa có tài khoản? Đăng ký ngay!');
      expect(registerLink, findsOneWidget);

      await tester.tap(registerLink);
      await tester.pumpAndSettle();

      expect(find.byType(RegisterPage), findsOneWidget);
    });

    testWidgets('Kiểm tra input với email và mật khẩu',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginPage()));

      final emailField = find.widgetWithText(TextField, 'Địa chỉ email');
      final passwordField = find.widgetWithText(TextField, 'Mật khẩu');

      await tester.enterText(emailField, 'test@example.com');
      await tester.enterText(passwordField, 'password123');
      await tester.pump();

      expect(find.text('test@example.com'), findsOneWidget);
      expect(find.text('password123'), findsOneWidget);
    });
  });
}
