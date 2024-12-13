import 'package:admin/model/stat.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdminChart extends StatelessWidget {
  final List<Stat> stats;

  const AdminChart({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: 500,
          height: 500,
          child: LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                  spots: stats
                      .map(
                        (stat) => FlSpot(
                          stats.indexOf(stat).toDouble(),
                          (stat.money ?? 0.0),
                        ),
                      )
                      .toList(),
                  isCurved: true,
                  color: Colors.blue,
                  barWidth: 4,
                  isStrokeCapRound: true,
                  belowBarData: BarAreaData(
                    show: true,
                    color: Colors.blue.withOpacity(0.3),
                  ),
                ),
              ],
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    interval: 500,
                    getTitlesWidget: (value, meta) {
                      return Text(value.toStringAsFixed(0));
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    interval: 5,
                    getTitlesWidget: (value, meta) {
                      int index = value.toInt();
                      if (index >= 0 && index < stats.length) {
                        final stat = stats[index];
                        return Text(
                          DateFormat('dd/MM').format(
                            DateTime.fromMillisecondsSinceEpoch(stat.date! * 1000),
                          ),
                          style: TextStyle(fontSize: 10),
                        );
                      }
                      return const Text('');
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(
                show: true,
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              gridData: FlGridData(show: true),
              minX: 0,
              maxX: stats.length.toDouble() - 1,
              minY: 0,
              maxY: stats.map((e) => e.money ?? 0.0).reduce((a, b) => a > b ? a : b),
            ),
          ),
        );
      },
    );
  }
}
