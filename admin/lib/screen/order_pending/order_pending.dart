import 'package:admin/model/order_pending.dart' as model;
import 'package:admin/repository/order_pending_repository.dart';
import 'package:admin/screen/exception/exception_page.dart';
import 'package:admin/service/getit_helper.dart';
import 'package:admin/service/toast_helper.dart';
import 'package:flutter/material.dart';

class OrderPending extends StatefulWidget {
  const OrderPending({super.key});

  @override
  State<OrderPending> createState() => _OrderPendingState();
}

class _OrderPendingState extends State<OrderPending> {
  late List<model.OrderPending> data;

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
          'Mã đơn hàng',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      DataColumn(
        label: Text(
          'Sản phẩm',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      DataColumn(
        label: Text(
          'Ngày xuất',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      DataColumn(
        label: Text(
          'Tên khách hàng',
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

  List<DataRow> _buildRows(List<model.OrderPending> orders) {
    return orders.map((order) {
      return DataRow(
        cells: [
          DataCell(Text(order.orderPendingId.toString())),
          DataCell(
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...order.listProductOrederPending!.map(
                  (e) => Text(e.productName!),
                ),
              ],
            ),
          ),
          DataCell(Text(order.odertDate!)),
          DataCell(Text(order.customerName!)),
          DataCell(
            DropdownButton<String>(
              items: const [
                DropdownMenuItem(
                  value: 'pending',
                  child: Text('Đang chờ'),
                ),
                DropdownMenuItem(
                  value: 'cancel',
                  child: Text('Hủy'),
                ),
                DropdownMenuItem(
                  value: 'approve',
                  child: Text('Xác nhận'),
                ),
              ],
              value: order.status!.toLowerCase(),
              onChanged: (String? value) async {
                if (value == null || value == 'pending') return;
                try {
                  await GetItHelper.get<OrderPendingRepository>().changeOrderPending(
                    order: order,
                    status: value,
                  );
                  _showToast(
                    message: 'Sửa trạng thái đơn hàng thành công',
                    isSuccess: true,
                  );
                  setState(() {});
                } catch (e) {
                  _showToast(
                    message: 'Thất bại: ${e.toString()}',
                    isSuccess: false,
                  );
                }
              },
            ),
          ),
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: GetItHelper.get<OrderPendingRepository>().getAllOrderPending(status: 'pending'),
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
          data = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
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
            child: Text('Không có đơn hàng để load'),
          );
        }
      },
    );
  }
}
