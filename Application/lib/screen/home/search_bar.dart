import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/provider/theme_provider.dart';

class SearchBar extends ConsumerWidget {
  const SearchBar({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.read(themeProvider);
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: InkWell(
          onTap: () {},
          child: const Icon(Icons.search_outlined),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.0,
            color: theme == ThemeMode.dark
                ? Colors.white.withOpacity(0.95)
                : Colors.black.withOpacity(0.95),
          ),
          borderRadius: BorderRadius.circular(18.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.0,
            color: theme == ThemeMode.dark
                ? Colors.white.withOpacity(0.95)
                : Colors.black.withOpacity(0.95),
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        hintText: 'Nhập tên sản phẩm bạn muốn tìm...',
      ),
    );
  }
}
