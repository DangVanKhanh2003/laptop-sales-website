import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shopping_app/screen/setting/change_password/change_fail.dart';
import 'package:shopping_app/screen/setting/change_password/change_success.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  late final GlobalKey<FormState> _formKey;

  late final TextEditingController _oldPasswordController;

  late final TextEditingController _newPasswordController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _newPasswordController = TextEditingController();
    _oldPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _toSucessScreen() {
    Navigator.of(context).pushReplacement(
      PageTransition(
        child: const ChangeSuccess(),
        type: PageTransitionType.fade,
        duration: const Duration(milliseconds: 500),
      ),
    );
  }

  void _toErrorScreen(String e) {
    Navigator.of(context).pushReplacement(
      PageTransition(
        child: ChangeFail(error: e),
        type: PageTransitionType.fade,
        duration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đổi mật khẩu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  const Text('Mật khẩu cũ: '),
                  const SizedBox(width: 30),
                  Expanded(
                    child: TextFormField(
                      controller: _oldPasswordController,
                      decoration: const InputDecoration(
                        hintText: 'Nhập mật khẩu cũ',
                      ),
                      obscureText: true,
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
                children: [
                  const Text('Mật khẩu mới: '),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                      controller: _oldPasswordController,
                      decoration: const InputDecoration(
                        hintText: 'Nhập mật khẩu mới',
                      ),
                      obscureText: true,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Mật khẩu không được trống';
                        }
                        if (!RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$')
                            .hasMatch(value)) {
                          return 'Mật khẩu không hợp lệ';
                        }
                        if (_newPasswordController.text ==
                            _oldPasswordController.text) {
                          return 'Mật khẩu mới không được trùng mật khẩu cũ';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              TextButton(
                style: ButtonStyle(
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      // TODO : Thêm tính năng đổi mk
                      _toSucessScreen();
                    } catch (e) {
                      _toErrorScreen(e.toString());
                    }
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 12.0,
                  ),
                  child: Text('Đổi mật khẩu'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
