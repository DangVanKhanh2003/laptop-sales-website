import 'package:admin/model/stat.dart';
import 'package:admin/repository/stats_repository.dart';
import 'package:admin/screen/dashboard/admin_barchart.dart';
import 'package:admin/screen/dashboard/admin_chart.dart';
import 'package:admin/screen/dashboard/admin_piechart.dart';
import 'package:admin/screen/exception/exception_page.dart';
import 'package:admin/service/getit_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DashboardAnalysis extends StatefulWidget {
  const DashboardAnalysis({
    super.key,
    required this.startTime,
    required this.endTime,
  });

  final DateTime startTime;

  final DateTime endTime;

  @override
  State<DashboardAnalysis> createState() => _DashboardAnalysisState();
}

class _DashboardAnalysisState extends State<DashboardAnalysis> {
  late double _totalMoney;
  late int _totalProduct;
  late Future<List<Stat>> _future;

  int _convertToUnixTimestamp(DateTime dateTime) {
    return dateTime.millisecondsSinceEpoch ~/ 1000;
  }

  DateTime _convertFromUnixTimestamp(int unixTimestamp) {
    return DateTime.fromMillisecondsSinceEpoch(unixTimestamp * 1000);
  }

  @override
  void initState() {
    _totalMoney = 0.0;
    _totalProduct = 0;
    _future = GetItHelper.get<StatsRepository>().getStatsDetail(
      startTime: _convertToUnixTimestamp(widget.startTime),
      endTime: _convertToUnixTimestamp(widget.endTime),
    );
    super.initState();
  }

  String _formatDate(DateTime date) {
    final formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(date);
  }

  String _formatCurrency(double value) {
    final formatter = NumberFormat.currency(symbol: '\$', decimalDigits: 2);
    return formatter.format(value);
  }

  void _calculateData(List<Stat> stats) {
    for (var stat in stats) {
      _totalMoney += stat.money!;
      _totalProduct += stat.amount!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kết quả thống kê'),
      ),
      body: FutureBuilder<List<Stat>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (snapshot.hasError) {
            return ExceptionPage(message: snapshot.error.toString());
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            _calculateData(data);
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AdminChart(stats: data),
                      AdminBarChart(stats: data),
                      AdminPieChart(stats: data),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  // Header
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: Colors.blue.shade50,
                    child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tổng tiền hàng: ${_formatCurrency(_totalMoney)}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              'Tổng số hàng bán ra: $_totalProduct',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Divider(thickness: 1.0, color: Colors.grey),
                  const SizedBox(height: 8.0),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final stat = data[index];
                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: const EdgeInsets.only(bottom: 16.0),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ngày: ${_formatDate(_convertFromUnixTimestamp(stat.date!))}',
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Số lượng: ${stat.amount!}',
                                    style: const TextStyle(fontSize: 14.0),
                                  ),
                                  Text(
                                    'Số tiền: ${_formatCurrency(stat.money!)}',
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.green,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
