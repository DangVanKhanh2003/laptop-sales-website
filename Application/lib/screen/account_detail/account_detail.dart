import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  late TextEditingController _fullNameController;

  late TextEditingController _phoneController;
  late TextEditingController _provinceController;
  late TextEditingController _districtController;
  late TextEditingController _communeController;
  late TextEditingController _streetController;
  late TextEditingController _numberHouseController;

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
            child: TextField(
              controller: controller,
            ),
          ),
        ],
      ),
    );
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _InfoCard(
                      title: 'Thông tin cá nhân',
                      children: [
                        _buildTextFieldRow(
                          label: 'Họ và tên',
                          controller: _fullNameController,
                        ),
                        _buildTextFieldRow(
                          label: 'Số điện thoại',
                          controller: _phoneController,
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
                        ),
                        _buildTextFieldRow(
                          label: 'Quận/Huyện',
                          controller: _districtController,
                        ),
                        _buildTextFieldRow(
                          label: 'Phường/Xã',
                          controller: _communeController,
                        ),
                        _buildTextFieldRow(
                          label: 'Phố',
                          controller: _streetController,
                        ),
                        _buildTextFieldRow(
                          label: 'Số nhà',
                          controller: _numberHouseController,
                        ),
                      ],
                    ),
                  ],
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
