import 'package:flutter/material.dart';
import 'package:shopping_app/model/cart.dart';
import 'package:shopping_app/screen/payment/booking_payment.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({
    super.key,
    required this.cart,
    required this.money,
  });

  final List<CartItem> cart;

  final double money;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  TableRow _sizedRow({
    required double height,
  }) {
    return TableRow(children: [
      SizedBox(height: height),
      SizedBox(height: height),
    ]);
  }

  late final TextEditingController _customerNameController;

  late final TextEditingController _customerPhone;

  @override
  void initState() {
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
          'Thông tin sân',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15.0),
        const Text('Tên sân A'),
        const SizedBox(height: 15.0),
        const Text('Sân số 01'),
        const SizedBox(height: 15.0),
        const Text('Minh Khai, Bắc Từ Liêm, Hà Nội'),
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
            _makeRow(title: 'Số lượng người', message: '7 VS 7'),
            _sizedRow(height: 8.0),
            _makeRow(title: 'Ngày', message: '11/07/2024'),
            _sizedRow(height: 8.0),
            _makeRow(title: 'Thời gian', message: '16:00 - 18:00'),
            _sizedRow(height: 8.0),
            _makeRow(title: 'Số điện thoại chủ sân', message: '0123456789'),
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
            _makeRow(title: 'Đơn giá', message: '400.000đ'),
            _sizedRow(height: 8.0),
            _makeRow(title: 'Giá cọc', message: '100.000đ'),
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
        Column(
          children: [
            Row(
              children: [
                const Text('Tên khách hàng'),
                const SizedBox(width: 30.0),
                Expanded(
                  child: TextField(
                    controller: _customerNameController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      enabledBorder: UnderlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                const Text('Số điện thoại'),
                const SizedBox(width: 54.0),
                Expanded(
                  child: TextField(
                    controller: _customerPhone,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      enabledBorder: UnderlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ],
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
            color: Color(0xFF013237),
          ),
        ),
      ),
      body: SingleChildScrollView(
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
            ClipPath(
              child: Container(
                height: 50,
                color: Colors.grey[300],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: _PaymentAppbar(
          money: widget.money,
        ),
      ),
    );
  }
}

/// App bar cho nút thanh toán và quay lại

class _PaymentAppbar extends StatelessWidget {
  final double money;

  const _PaymentAppbar({
    required this.money,
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
                color: Color(0xFF013237),
              ),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => BookingPayment(
                  money: money,
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
                color: Color(0xFF013237),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
