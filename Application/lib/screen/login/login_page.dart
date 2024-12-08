import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shopping_app/provider/token_provider.dart';
import 'package:shopping_app/repository/customer_repository.dart';
import 'package:shopping_app/screen/register/register_page.dart';
import 'package:shopping_app/screen/root/root_screen.dart';
import 'package:shopping_app/service/getit_helper.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  late final TextEditingController _emailController;

  late final TextEditingController _passwordController;

  late final GlobalKey<FormState> _formKey;

  bool _isLoading = false;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _toMainScreen() {
    Navigator.of(context).pushReplacement(
      PageTransition(
        child: const RootScreen(),
        type: PageTransitionType.fade,
        duration: const Duration(milliseconds: 500),
      ),
    );
  }

  void _showError(
    String message,
  ) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Lỗi xảy ra'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Vui lòng đăng nhập',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Card(
                elevation: 8.0,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                icon: Icon(Symbols.person_filled),
                                hintText: 'Địa chỉ email',
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Email không được trống';
                                }
                                if (!RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                                  return 'Email không hợp lệ';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextFormField(
                              obscureText: true,
                              controller: _passwordController,
                              decoration: const InputDecoration(
                                icon: Icon(Symbols.key),
                                hintText: 'Mật khẩu',
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Mật khẩu không được trống';
                                }
                                if (!RegExp(
                                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$')
                                    .hasMatch(value)) {
                                  return 'Mật khẩu không hợp lệ';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      TextButton(
                        style: ButtonStyle(
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                        onPressed: _isLoading
                            ? null
                            : () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  try {
                                    final token = await GetItHelper.get<
                                            CustomerRepository>()
                                        .login(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    );
                                    ref.watch(tokenProvider).clone(token);
                                    await ref
                                        .watch(tokenProvider.notifier)
                                        .loadToken();
                                    _toMainScreen();
                                  } catch (e) {
                                    _showError(e.toString());
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  }
                                }
                              },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _isLoading
                              ? const CircularProgressIndicator.adaptive()
                              : const Text('Đăng nhập'),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            child: Text(
                              'Bạn chưa có tài khoản? Đăng ký ngay!',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.redAccent.withOpacity(0.84),
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const RegisterPage(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 12.0),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
