import 'package:flutter/material.dart';

class AddUser extends StatefulWidget {
  const AddUser({
    super.key,
    required this.user,
  });

  final Map<String, String> user;

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              label: Text('Email'),
            ),
            onChanged: (String value) {
              widget.user['email'] = value;
            },
          ),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(
              label: Text('Mật khẩu'),
            ),
            onChanged: (String value) {
              widget.user['password'] = value;
            },
          ),
        ],
      ),
    );
  }
}
