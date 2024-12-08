import 'package:admin/model/category.dart';
import 'package:admin/model/product.dart';
import 'package:admin/repository/category_repository.dart';
import 'package:admin/screen/exception/exception_page.dart';
import 'package:admin/service/convert_helper.dart';
import 'package:admin/service/getit_helper.dart';
import 'package:admin/service/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  List<Category>? _categogies;

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

  Widget _buildUI() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              label: Text('Tên sản phẩm'),
            ),
            onChanged: (String value) {
              widget.product.productName = value;
            },
          ),
          const SizedBox(height: 10.0),
          TextField(
            controller: _brandController,
            decoration: const InputDecoration(
              label: Text('Hãng sản phẩm'),
            ),
            onChanged: (String value) {
              widget.product.brand = value;
            },
          ),
          const SizedBox(height: 10.0),
          TextField(
            controller: _seriesController,
            decoration: const InputDecoration(
              label: Text('Series'),
            ),
            onChanged: (String value) {
              widget.product.series = value;
            },
          ),
          const SizedBox(height: 10.0),
          TextFormField(
            controller: _priceController,
            decoration: const InputDecoration(
              label: Text('Giá bán'),
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (String value) {
              widget.product.price = double.parse(value);
            },
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              const Text('Danh mục'),
              const SizedBox(width: 10.0),
              Expanded(
                child: DropdownButton<int>(
                    items: [
                      ..._categogies!.map(
                        (e) => DropdownMenuItem(
                          value: e.categoryId!,
                          child: Text(e.categoryName!),
                        ),
                      )
                    ],
                    value: widget.product.category!.categoryId!,
                    onChanged: (int? value) {
                      if (value == null) return;
                      setState(() {
                        widget.product.category!.categoryId = value;
                      });
                    }),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          widget.product.mainImg == null
              ? const Text('Chưa chọn ảnh')
              : Image(
                  image: MemoryImage(
                    ConvertHelper.decodeBase64(data: widget.product.mainImg!),
                  ),
                ),
          const SizedBox(height: 10.0),
          ElevatedButton(
            onPressed: () async {
              final image =
                  await ImageHelper.pickImage(source: ImageSource.gallery);
              // Hủy thao tác
              if (image == null) return;
              setState(() {
                widget.product.mainImg =
                    ConvertHelper.encodeBase64(data: image);
              });
            },
            child: const Text('Tải ảnh lên'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _categogies == null
        ? FutureBuilder(
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
                _categogies = snapshot.data!.categoryList!;
                return _buildUI();
              } else {
                return const Center(
                  child: Text('Không thể tải được danh mục'),
                );
              }
            },
          )
        : _buildUI();
  }
}
