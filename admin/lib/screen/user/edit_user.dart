import 'package:flutter/material.dart';

class EditUser extends StatefulWidget {
  const EditUser({
    super.key,
    required this.user,
  });

  final Map<String, String> user;

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  late TextEditingController _passwordController;

  @override
  void initState() {
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
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
            controller: _passwordController,
            decoration: const InputDecoration(
              label: Text('Mật khẩu mới'),
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
