import 'package:admin/model/category.dart';
import 'package:admin/repository/category_repository.dart';
import 'package:admin/screen/category/add_category.dart';
import 'package:admin/screen/category/edit_category.dart';
import 'package:admin/screen/exception/exception_page.dart';
import 'package:admin/service/getit_helper.dart';
import 'package:admin/service/toast_helper.dart';
import 'package:flutter/material.dart';

class ManageCategory extends StatefulWidget {
  const ManageCategory({super.key});

  @override
  State<ManageCategory> createState() => _ManageCategoryState();
}

class _ManageCategoryState extends State<ManageCategory> {
  late List<Category> data;

  @override
  void initState() {
    super.initState();
  }

  void _showToast({
    required String message,
    required bool isSuccess,
  }) {
    ToastHelper.showToast(
      context: context,
      message: message,
      color: isSuccess ? Colors.green : Colors.red,
    );
  }

  void _onDelete(int categoryId) async {
    try {
      final state = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text('Xóa danh mục'),
          content: Text('Bạn có chắc chắn muốn xóa danh mục mã $categoryId?'),
          actions: [
            TextButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text(
                'Đồng ý',
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text(
                'Hủy',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      );
      if (state) {
        await GetItHelper.get<CategoryRepository>().deleteCategory(
          categoryId: categoryId,
        );
        _showToast(message: 'Xóa danh mục thành công', isSuccess: true);
        setState(() {});
      }
    } catch (e) {
      _showToast(message: 'Lỗi xảy ra: ${e.toString()}', isSuccess: false);
    }
  }

  void _onEdit(int categoryId) async {
    try {
      final category = data.firstWhere((e) => e.categoryId == categoryId);
      final state = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text('Sửa danh mục'),
          content: EditCategory(
            category: category,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Hoàn tất'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Hủy'),
            ),
          ],
        ),
      );
      if (state) {
        await GetItHelper.get<CategoryRepository>().editCategory(
          category: category,
        );
        _showToast(message: 'Sửa danh mục thành công', isSuccess: true);
        setState(() {});
      }
    } catch (e) {
      _showToast(message: 'Lỗi xảy ra: ${e.toString()}', isSuccess: false);
    }
  }

  Widget _buildTable() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: constraints.maxWidth),
            child: DataTable(
              columnSpacing: 40,
              headingRowHeight: 50,
              columns: _buildColumns(),
              rows: _buildRows(data),
            ),
          ),
        );
      },
    );
  }

  List<DataColumn> _buildColumns() {
    return const [
      DataColumn(
        label: Text(
          'Mã danh mục',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      DataColumn(
        label: Text(
          'Tên danh mục',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      DataColumn(
        label: Text(
          'Icon danh mục',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      DataColumn(
        label: Text(
          'Thao tác',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    ];
  }

  List<DataRow> _buildRows(List<Category> categories) {
    return categories.map((category) {
      return DataRow(
        cells: [
          DataCell(Text(category.categoryId.toString())),
          DataCell(Text(category.categoryName!)),
          DataCell(Text(category.categoryIcon!)),
          DataCell(
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.edit_outlined),
                  color: Colors.blue,
                  onPressed: () => _onEdit(category.categoryId!),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  color: Colors.red,
                  onPressed: () => _onDelete(category.categoryId!),
                ),
              ],
            ),
          ),
        ],
      );
    }).toList();
  }

  void _onAdd() async {
    try {
      final category = Category(categoryName: '', categoryIcon: 'abc');
      final state = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text('Thêm danh mục'),
          content: AddCategory(
            category: category,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Thêm'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Hủy'),
            ),
          ],
        ),
      );
      if (state) {
        await GetItHelper.get<CategoryRepository>().addCategory(
          category: category,
        );
        _showToast(message: 'Thêm danh mục thành công', isSuccess: true);
        setState(() {});
      }
    } catch (e) {
      _showToast(message: 'Lỗi xảy ra: ${e.toString()}', isSuccess: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: GetItHelper.get<CategoryRepository>().getAllCategory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: ExceptionPage(message: snapshot.error.toString()),
          );
        } else if (snapshot.hasData) {
          data = snapshot.data!.categoryList!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Row(
                    children: [
                      TextButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan,
                        ),
                        onPressed: _onAdd,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 12.0),
                          child: Text(
                            'Thêm',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: _buildTable(),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(
            child: Text('Không có danh mục để load'),
          );
        }
      },
    );
  }
}
