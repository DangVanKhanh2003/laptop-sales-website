import 'package:flutter/material.dart';

class BookingPayment extends StatefulWidget {
  const BookingPayment({
    super.key,
    required this.money,
  });

  final double money;

  @override
  State<BookingPayment> createState() => _BookingPaymentState();
}

class _BookingPaymentState extends State<BookingPayment> {
  /// Thời gian đếm ngược còn lại

  late Duration timeLeft;

  @override
  void initState() {
    timeLeft = const Duration(minutes: 10);
    super.initState();
    startTimer();
  }

  void startTimer() {
    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (mounted && timeLeft.inSeconds > 0) {
          setState(() {
            timeLeft -= const Duration(seconds: 1);
          });
          startTimer();
        }
      },
    );
  }

  String getMinutes(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    return minutes;
  }

  String getSeconds(Duration duration) {
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return seconds;
  }

  Widget _counterWidget(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF013237),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _timeCounter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Thời gian thanh toán còn lại',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Row(
          children: [
            _counterWidget(getMinutes(timeLeft)),
            const SizedBox(width: 4.0),
            const Text(
              ':',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF013237),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 4.0),
            _counterWidget(getSeconds(timeLeft)),
          ],
        ),
      ],
    );
  }

  TableRow _sizedRow({
    required double height,
  }) {
    return TableRow(children: [
      SizedBox(height: height),
      SizedBox(height: height),
    ]);
  }

  TableRow _widgetRow({
    required String title,
    required String description,
  }) {
    return TableRow(
      children: [
        Text(title),
        Text(
          description,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF013237),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        title: Image.asset(
          'assets/images/vnpay.png',
          width: 150,
          height: 150,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Divider(
            thickness: 1.0,
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 4.0,
            ),
            child: _timeCounter(),
          ),
          const Divider(
            thickness: 1.0,
            color: Colors.grey,
          ),
          const SizedBox(height: 15.0),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 4.0,
            ),
            child: Table(
              columnWidths: const {
                0: FlexColumnWidth(5),
                1: FlexColumnWidth(1),
              },
              children: [
                _widgetRow(
                  title: 'Đơn vị chấp nhận thanh toán',
                  description: 'Nhóm 7',
                ),
                _sizedRow(height: 8.0),
                _widgetRow(
                  title: 'Số tiền thanh toán',
                  description: widget.money.toString(),
                ),
                _sizedRow(height: 8.0),
                _widgetRow(title: 'Phí giao dịch', description: '0đ'),
              ],
            ),
          ),
          const SizedBox(height: 15.0),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(
              thickness: 1.0,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 15.0),
          Image.asset(
            'assets/images/qr.png',
            width: 250,
            height: 250,
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: _PaymentAppbar(),
      ),
    );
  }
}

/// App bar cho nút xác nhận và quay lại

class _PaymentAppbar extends StatelessWidget {
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
            // TODO
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
            child: Text(
              'Xác nhận',
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
