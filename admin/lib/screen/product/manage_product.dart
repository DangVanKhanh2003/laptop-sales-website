import 'package:admin/model/category.dart';
import 'package:admin/model/product.dart';
import 'package:admin/repository/product_repository.dart';
import 'package:admin/screen/exception/exception_page.dart';
import 'package:admin/screen/product/add_product.dart';
import 'package:admin/screen/product/edit_product.dart';
import 'package:admin/service/getit_helper.dart';
import 'package:admin/service/toast_helper.dart';
import 'package:flutter/material.dart';

class ManageProduct extends StatefulWidget {
  const ManageProduct({
    super.key,
  });

  @override
  State<ManageProduct> createState() => _ManageProductState();
}

class _ManageProductState extends State<ManageProduct> {
  late List<Product> data;

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

  void _onDelete(int productId) async {
    try {
      final state = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text('Xác nhận xóa'),
          content: Text('Bạn có chắc chắn muốn xóa sản phẩm mã $productId?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Đồng ý'),
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
        await GetItHelper.get<ProductRepository>().deleteProduct(
          productId: productId,
        );
        _showToast(message: 'Xóa sản phẩm thành công', isSuccess: true);
        setState(() {});
      }
    } catch (e) {
      _showToast(message: 'Lỗi xảy ra: ${e.toString()}', isSuccess: false);
    }
  }

  void _onEdit(int productId) async {
    try {
      final product = data.firstWhere((e) => e.productId! == productId);
      final state = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text('Sửa sản phẩm'),
          content: EditProduct(product: product),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Đồng ý'),
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
        await GetItHelper.get<ProductRepository>().editProduct(
          productId: productId,
          product: product,
          categoryId: product.category!.categoryId!,
        );
        _showToast(message: 'Sửa sản phẩm thành công', isSuccess: true);
        setState(() {});
      }
    } catch (e) {
      _showToast(message: 'Lỗi xảy ra: ${e.toString()}', isSuccess: false);
    }
  }

  void _onAdd() async {
    try {
      final product = Product(category: Category(categoryId: 1), price: 0.0);
      final state = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text('Thêm sản phẩm'),
          content: AddProduct(product: product),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Đồng ý'),
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
        await GetItHelper.get<ProductRepository>().addProduct(
          brand: product.brand!,
          categoryId: product.category!.categoryId!,
          mainImg: product.mainImg!,
          price: product.price!,
          productName: product.productName!,
          series: product.series!,
        );
        _showToast(message: 'Thêm sản phẩm thành công', isSuccess: true);
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
          'Mã sản phẩm',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      DataColumn(
        label: Text(
          'Tên sản phẩm',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      DataColumn(
        label: Text(
          'Hãng sản phẩm',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      DataColumn(
        label: Text(
          'Series',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      DataColumn(
        label: Text(
          'Giá bán',
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
          'Thao tác',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    ];
  }

  List<DataRow> _buildRows(List<Product> products) {
    return products.map((product) {
      return DataRow(
        cells: [
          DataCell(Text(product.productId.toString())),
          DataCell(Text(product.productName!)),
          DataCell(Text(product.brand!)),
          DataCell(Text(product.series!)),
          DataCell(Text('\$${product.price}')),
          DataCell(Text(product.category!.categoryName!)),
          DataCell(
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.edit_outlined),
                  color: Colors.blue,
                  onPressed: () => _onEdit(product.productId!),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  color: Colors.red,
                  onPressed: () => _onDelete(product.productId!),
                ),
              ],
            ),
          ),
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: GetItHelper.get<ProductRepository>().getProduct(),
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
          data = snapshot.data!.productList!;
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
                          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
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
