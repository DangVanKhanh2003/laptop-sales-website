import 'package:admin/model/product.dart';
import 'package:admin/repository/category_repository.dart';
import 'package:admin/screen/exception/exception_page.dart';
import 'package:admin/service/getit_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  late TextEditingController _nameController;
  late TextEditingController _brandController;
  late TextEditingController _seriesController;
  late TextEditingController _priceController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _brandController = TextEditingController();
    _seriesController = TextEditingController();
    _priceController = TextEditingController(text: '0.0');
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _brandController.dispose();
    _seriesController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
          final categories = snapshot.data!.categoryList!;
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    label: Text('Tên sản phẩm'),
                  ),
                ),
                const SizedBox(height: 10.0),
                TextField(
                  controller: _brandController,
                  decoration: const InputDecoration(
                    label: Text('Hãng sản phẩm'),
                  ),
                ),
                const SizedBox(height: 10.0),
                TextField(
                  controller: _seriesController,
                  decoration: const InputDecoration(
                    label: Text('Series'),
                  ),
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  controller: _priceController,
                  decoration: const InputDecoration(
                    label: Text('Giá bán'),
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
                const SizedBox(height: 10.0),
                DropdownButton<int>(
                    items: [],
                    onChanged: (int? value) {
                      setState(() {
                        // TODO : Đổ danh mục vào
                      });
                    })
              ],
            ),
          );
        } else {
          return const Center(
            child: Text('Không thể tải được danh mục'),
          );
        }
      },
    );
  }
}
