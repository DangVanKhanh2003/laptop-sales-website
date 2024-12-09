import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/model/customer_info.dart';
import 'package:shopping_app/model/order_pending.dart';
import 'package:shopping_app/model/payment.dart';
import 'package:shopping_app/provider/token_provider.dart';
import 'package:shopping_app/repository/customer_repository.dart';
import 'package:shopping_app/screen/exception/exception_page.dart';
import 'package:shopping_app/screen/payment/finish_payment.dart';
import 'package:shopping_app/service/getit_helper.dart';

class PaymentPage extends ConsumerStatefulWidget {
  const PaymentPage({
    super.key,
    required this.data,
    required this.money,
  });

  final List<Payment> data;

  final double money;

  @override
  ConsumerState<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends ConsumerState<PaymentPage> {
  late final TextEditingController _customerNameController;

  late final TextEditingController _customerPhone;

  late Future<CustomerInfo> _future;

  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _future = GetItHelper.get<CustomerRepository>().getCustomerInfoById(
      customerId: ref.read(tokenProvider.notifier).customerId,
      token: ref.read(tokenProvider),
    );
    _formKey = GlobalKey<FormState>();
    super.initState();
    _customerNameController = TextEditingController();
    _customerPhone = TextEditingController();
  }

  @override
  void dispose() {
    _customerNameController.dispose();
    _customerPhone.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  TableRow _sizedRow({
    required double height,
  }) {
    return TableRow(children: [
      SizedBox(height: height),
      SizedBox(height: height),
    ]);
  }

  TableRow _makeRow({
    required String title,
    required String message,
  }) {
    return TableRow(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(title),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(message),
          ],
        ),
      ],
    );
  }

  Widget _fieldInformation() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8.0),
        const Text(
          'Thông tin sản phẩm',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 7.0),
        const Divider(
          thickness: 1.0,
          color: Colors.grey,
        ),
        const SizedBox(height: 7.0),
        Column(
          children: [
            ...widget.data.asMap().entries.map(
                  (e) => Card(
                    child: ListTile(
                      leading: Text('${e.key + 1}'),
                      title: Text(e.value.productName),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 4.0),
                          Text('Giá: \$${e.value.price}'),
                          SizedBox(height: 4.0),
                          Text('Số lượng sản phẩm: ${e.value.amount}'),
                          SizedBox(height: 4.0),
                        ],
                      ),
                    ),
                  ),
                )
          ],
        ),
        const SizedBox(height: 10.0),
        const Divider(
          thickness: 1.0,
          color: Colors.grey,
        ),
        const SizedBox(height: 10.0),
        Table(
          columnWidths: const {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(1),
          },
          children: [
            _makeRow(title: 'Đơn giá', message: '\$${widget.money}'),
            _sizedRow(height: 8.0),
            _makeRow(title: 'Thuế VAT', message: '\$0.0'),
          ],
        ),
      ],
    );
  }

  Widget _customerInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8.0),
        const Text(
          'Thông tin khách hàng',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 8.0),
              TextField(
                controller: _customerNameController,
                decoration: const InputDecoration(
                  label: Text('Tên khách hàng'),
                  border: UnderlineInputBorder(),
                  enabledBorder: UnderlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: _customerPhone,
                decoration: const InputDecoration(
                  label: Text('Số điện thoại'),
                  border: UnderlineInputBorder(),
                  enabledBorder: UnderlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8.0),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Xác nhận',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: ExceptionPage(
                message: snapshot.error.toString(),
              ),
            );
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            if (_customerNameController.text.isEmpty) {
              _customerNameController.text = data.fullName!;
            }
            if (_customerPhone.text.isEmpty) {
              _customerPhone.text = data.phoneNumber!;
            }
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(
                    thickness: 1.0,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 12.0,
                    ),
                    child: _fieldInformation(),
                  ),
                  const Divider(
                    thickness: 1.0,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 12.0,
                    ),
                    child: _customerInfo(),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: _PaymentAppbar(
          money: widget.money,
          data: widget.data,
        ),
      ),
    );
  }
}

/// App bar cho nút thanh toán và quay lại

class _PaymentAppbar extends StatelessWidget {
  final double money;
  final List<Payment> data;

  const _PaymentAppbar({
    required this.money,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
            child: Text(
              'Quay lại',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => FinishPayment(
                  list: [
                    ...data.map(
                      (e) => ListProductOrederPending(
                        productId: e.productId,
                        amount: e.amount,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
            child: Text(
              'Thanh toán',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
