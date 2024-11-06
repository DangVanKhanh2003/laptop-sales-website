import 'package:flutter/material.dart';
import 'package:shopping_app/screen/search/search_page.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SearchPage(name: controller.text),
              ),
            );
          },
          child: const Icon(Icons.search_outlined),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.0,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white.withOpacity(0.75)
                : Colors.black.withOpacity(0.75),
          ),
          borderRadius: BorderRadius.circular(30.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.0,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white.withOpacity(0.75)
                : Colors.black.withOpacity(0.75),
          ),
          borderRadius: BorderRadius.circular(30.0),
        ),
        hintText: 'Tìm sản phẩm...',
      ),
    );
  }
}
