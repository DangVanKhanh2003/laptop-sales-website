import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/screen/login/login_page.dart';
import 'package:shopping_app/screen/register/register_page.dart';

void main() {
  group('Kiểm thử chức năng đăng ký', () {
    testWidgets('Hiển thị giao diện đăng ký', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: RegisterPage()));

      expect(find.text('Đăng ký tài khoản'), findsOneWidget);
    });

    testWidgets('Hiển thị email và mật khẩu', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: RegisterPage()));

      expect(find.byType(TextField), findsNWidgets(3));
      expect(find.text('Địa chỉ email'), findsOneWidget);
      expect(find.text('Mật khẩu'), findsOneWidget);
      expect(find.text('Xác nhận mật khẩu'), findsOneWidget);
    });

    testWidgets('Hiển thị nút đăng ký và thử nút đăng ký',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: RegisterPage()));

      final registerButton = find.text('Đăng ký');
      expect(registerButton, findsOneWidget);

      await tester.tap(registerButton);
      await tester.pump();
    });

    testWidgets(
        'Điều hướng vào màn hình đăng ký khi nhấn "Bạn đã có tài khoản? Đăng nhập!"',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: RegisterPage()));

      final registerLink = find.text('Bạn đã có tài khoản? Đăng nhập!');
      expect(registerLink, findsOneWidget);

      await tester.tap(registerLink);
      await tester.pumpAndSettle();

      expect(find.byType(LoginPage), findsOneWidget);
    });

    testWidgets('Kiểm tra input với email và mật khẩu',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: RegisterPage()));

      final emailField = find.widgetWithText(TextField, 'Địa chỉ email');
      final passwordField = find.widgetWithText(TextField, 'Mật khẩu');
      final confirmPasswordField =
          find.widgetWithText(TextField, 'Xác nhận mật khẩu');

      await tester.enterText(emailField, 'test@example.com');
      await tester.enterText(passwordField, 'password123');
      await tester.enterText(confirmPasswordField, 'password123');
      await tester.pump();

      expect(find.text('test@example.com'), findsOneWidget);
      expect(find.text('password123'), findsWidgets);
    });
  });
}
