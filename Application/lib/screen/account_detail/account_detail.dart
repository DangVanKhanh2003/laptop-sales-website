import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/model/address.dart';
import 'package:shopping_app/model/customer_info.dart';
import 'package:shopping_app/provider/token_provider.dart';
import 'package:shopping_app/repository/customer_repository.dart';
import 'package:shopping_app/screen/exception/exception_page.dart';
import 'package:shopping_app/service/getit_helper.dart';

class AccountDetail extends ConsumerStatefulWidget {
  const AccountDetail({super.key});

  @override
  ConsumerState<AccountDetail> createState() => _AccountDetailState();
}

class _AccountDetailState extends ConsumerState<AccountDetail> {
  late Future<CustomerInfo> _future;

  bool _isLoading = false;

  late TextEditingController _fullNameController;

  late TextEditingController _phoneController;
  late TextEditingController _provinceController;
  late TextEditingController _districtController;
  late TextEditingController _communeController;
  late TextEditingController _streetController;
  late TextEditingController _numberHouseController;

  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _phoneController = TextEditingController();
    _provinceController = TextEditingController();
    _districtController = TextEditingController();
    _communeController = TextEditingController();
    _streetController = TextEditingController();
    _numberHouseController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    _future = GetItHelper.get<CustomerRepository>().getCustomerInfoById(
      customerId: ref.read(tokenProvider.notifier).customerId,
      token: ref.read(tokenProvider),
    );
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _provinceController.dispose();
    _districtController.dispose();
    _communeController.dispose();
    _streetController.dispose();
    _numberHouseController.dispose();
    super.dispose();
  }

  Widget _buildTextFieldRow({
    required String label,
    required TextEditingController controller,
    String? Function(String? value)? validator,
    double spacing = 24.0,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(label),
            ),
          ),
          SizedBox(width: spacing),
          Expanded(
            child: TextFormField(
              controller: controller,
              validator: validator,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onError(String message) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Lỗi xảy ra'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Text(message),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _onSuccess() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Thành công'),
        content: const Text('Đã sửa thành công thông tin của bạn!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _close() {
    Navigator.of(context).pop();
  }

  void _onEdit() async {
    setState(() {
      _isLoading = true;
    });
    try {
      if (_formKey.currentState!.validate()) {
        await GetItHelper.get<CustomerRepository>().updateCustomerInfo(
          token: ref.read(tokenProvider),
          customerInfo: CustomerInfo(
            customerId: ref.read(tokenProvider.notifier).customerId,
            fullName: _fullNameController.text,
            phoneNumber: _phoneController.text,
            address: Address(
              province: _provinceController.text,
              district: _districtController.text,
              commune: _communeController.text,
              street: _streetController.text,
              numberHouse: _numberHouseController.text,
            ),
          ),
        );
        await _onSuccess();
        _close();
      }
    } catch (e) {
      await _onError(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin tài khoản'),
      ),
      body: FutureBuilder<CustomerInfo>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            _fullNameController.text = data.fullName ?? 'Chưa cung cấp';
            _phoneController.text = data.phoneNumber ?? 'Chưa cung cấp';
            if (data.address != null) {
              _provinceController.text =
                  data.address!.province ?? 'Chưa cung cấp';
              _districtController.text =
                  data.address!.district ?? 'Chưa cung cấp';
              _communeController.text =
                  data.address!.commune ?? 'Chưa cung cấp';
              _streetController.text = data.address!.street ?? 'Chưa cung cấp';
              _numberHouseController.text =
                  data.address!.numberHouse ?? 'Chưa cung cấp';
            } else {
              _provinceController.text = 'Chưa cung cấp';
              _districtController.text = 'Chưa cung cấp';
              _communeController.text = 'Chưa cung cấp';
              _streetController.text = 'Chưa cung cấp';
              _numberHouseController.text = 'Chưa cung cấp';
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _InfoCard(
                        title: 'Thông tin cá nhân',
                        children: [
                          _buildTextFieldRow(
                              label: 'Họ và tên',
                              controller: _fullNameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Tên không được rỗng';
                                }
                                if (!RegExp(
                                        r'^[A-ZÀÁẠẢÃÂẦẤẬẨẪĂẰẮẶẲẴÈÉẸẺẼÊỀẾỆỂỄÌÍỊỈĨÒÓỌỎÕÔỒỐỘỔỖƠỜỚỢỞỠÙÚỤỦŨƯỪỨỰỬỮỲÝỴỶỸĐ][a-zàáạảãâầấậẩẫăằắặẳẵèéẹẻẽêềếệểễìíịỉĩòóọỏõôồốộổỗơờớợởỡùúụủũưừứựửữỳýỵỷỹđ]*(?:[ ][A-ZÀÁẠẢÃÂẦẤẬẨẪĂẰẮẶẲẴÈÉẸẺẼÊỀẾỆỂỄÌÍỊỈĨÒÓỌỎÕÔỒỐỘỔỖƠỜỚỢỞỠÙÚỤỦŨƯỪỨỰỬỮỲÝỴỶỸĐ][a-zàáạảãâầấậẩẫăằắặẳẵèéẹẻẽêềếệểễìíịỉĩòóọỏõôồốộổỗơờớợởỡùúụủũưừứựửữỳýỵỷỹđ]*)*$')
                                    .hasMatch(value)) {
                                  return 'Tên không hợp lệ';
                                }
                                return null;
                              }),
                          _buildTextFieldRow(
                            label: 'Số điện thoại',
                            controller: _phoneController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Số điện thoại không được rỗng';
                              }
                              if (!RegExp(
                                      r'(03|05|07|08|09|01[2|6|8|9])+([0-9]{8})\b')
                                  .hasMatch(value)) {
                                return 'Số điện thoại không hợp lệ';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      _InfoCard(
                        title: 'Địa chỉ',
                        children: [
                          _buildTextFieldRow(
                            label: 'Thành phố',
                            controller: _provinceController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Địa chỉ không được rỗng';
                              }
                              return null;
                            },
                          ),
                          _buildTextFieldRow(
                            label: 'Quận/Huyện',
                            controller: _districtController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Quận/Huyện không được rỗng';
                              }
                              return null;
                            },
                          ),
                          _buildTextFieldRow(
                            label: 'Phường/Xã',
                            controller: _communeController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Phường/Xã không được rỗng';
                              }
                              return null;
                            },
                          ),
                          _buildTextFieldRow(
                            label: 'Phố',
                            controller: _streetController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Phố không được rỗng';
                              }
                              return null;
                            },
                          ),
                          _buildTextFieldRow(
                            label: 'Số nhà',
                            controller: _numberHouseController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Số nhà không được rỗng';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 12.0),
                      ElevatedButton(
                        onPressed: _isLoading ? null : _onEdit,
                        child: SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 24.0,
                            ),
                            child: _isLoading
                                ? const Center(
                                    child: CircularProgressIndicator.adaptive())
                                : const Center(child: Text('Sửa')),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: ExceptionPage(message: snapshot.error.toString()),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12.0),
            ...children,
          ],
        ),
      ),
    );
  }
}
