import 'package:admin/model/category.dart';
import 'package:flutter/material.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({
    super.key,
    required this.category,
  });

  final Category category;

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  late TextEditingController _categoryNameController;
  late TextEditingController _categoryIconController;

  @override
  void initState() {
    _categoryNameController = TextEditingController();
    _categoryIconController = TextEditingController(
      text: widget.category.categoryIcon!,
    );
    super.initState();
  }

  @override
  void dispose() {
    _categoryNameController.dispose();
    _categoryIconController.dispose();
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
            controller: _categoryNameController,
            decoration: const InputDecoration(
              label: Text('Tên danh mục'),
            ),
            onChanged: (String value) {
              widget.category.categoryName = value;
            },
          ),
          TextField(
            controller: _categoryIconController,
            decoration: const InputDecoration(
              label: Text('Icon danh mục'),
            ),
            onChanged: (String value) {
              widget.category.categoryIcon = value;
            },
          ),
        ],
      ),
    );
  }
}
