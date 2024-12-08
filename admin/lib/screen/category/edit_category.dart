import 'package:admin/model/category.dart';
import 'package:flutter/material.dart';

class EditCategory extends StatefulWidget {
  const EditCategory({
    super.key,
    required this.category,
  });

  final Category category;

  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  late TextEditingController _categoryIdController;
  late TextEditingController _categoryNameController;
  late TextEditingController _categoryIconController;

  @override
  void initState() {
    _categoryIdController = TextEditingController(
      text: widget.category.categoryId!.toString(),
    );
    _categoryNameController = TextEditingController(
      text: widget.category.categoryName!,
    );
    _categoryIconController = TextEditingController(
      text: widget.category.categoryIcon!,
    );
    super.initState();
  }

  @override
  void dispose() {
    _categoryIdController.dispose();
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
            controller: _categoryIdController,
            enabled: false,
            decoration: const InputDecoration(
              label: Text('Mã danh mục'),
            ),
          ),
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
