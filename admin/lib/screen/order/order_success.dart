import 'package:admin/model/order.dart';
import 'package:admin/repository/order_repository.dart';
import 'package:admin/screen/exception/exception_page.dart';
import 'package:admin/service/getit_helper.dart';
import 'package:flutter/material.dart';

class OrderSuccess extends StatefulWidget {
  const OrderSuccess({super.key});

  @override
  State<OrderSuccess> createState() => _OrderSuccessState();
}

class _OrderSuccessState extends State<OrderSuccess> {
  late List<Order> data;

  @override
  void initState() {
    super.initState();
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
    ];
  }

  List<DataRow> _buildRows(List<Order> orders) {
    return orders.map((order) {
      return DataRow(
        cells: [
          DataCell(Text(order.orderId.toString())),
          DataCell(
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...order.listProductOrder!.map(
                  (e) => Text(e.product!.productName!),
                ),
              ],
            ),
          ),
          DataCell(Text(order.dateExport!)),
          DataCell(Text(order.customerName!)),
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          GetItHelper.get<OrderRepository>().getAllOrders(status: 'approve'),
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
