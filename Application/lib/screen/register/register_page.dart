import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shopping_app/repository/customer_repository.dart';
import 'package:shopping_app/screen/login/login_page.dart';
import 'package:shopping_app/screen/root/root_screen.dart';
import 'package:shopping_app/service/getit_helper.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final TextEditingController _emailController;

  late final TextEditingController _passwordController;

  late final TextEditingController _passwordVerifyController;

  late final GlobalKey<FormState> _formKey;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordVerifyController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordVerifyController.dispose();
    super.dispose();
  }

  bool verifyPassword() {
    return _passwordController.text == _passwordVerifyController.text;
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
              'Đăng ký tài khoản',
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextFormField(
                              obscureText: true,
                              controller: _passwordVerifyController,
                              decoration: const InputDecoration(
                                icon: Icon(Symbols.key),
                                hintText: 'Xác nhận mật khẩu',
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
                                if (_passwordController.text !=
                                    _passwordVerifyController.text) {
                                  return 'Mật khẩu không trùng khớp';
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
                                setState(() {
                                  _isLoading = true;
                                });
                                if (_formKey.currentState!.validate()) {
                                  try {
                                    await GetItHelper.get<CustomerRepository>()
                                        .register(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    );
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
                              : const Text('Đăng ký'),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            child: Text(
                              'Bạn đã có tài khoản? Đăng nhập!',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.redAccent.withOpacity(0.84),
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ));
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
