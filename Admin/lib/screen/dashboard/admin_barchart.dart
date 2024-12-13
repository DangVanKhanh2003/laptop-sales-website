import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:admin/model/stat.dart';

class AdminBarChart extends StatelessWidget {
  final List<Stat> stats;

  const AdminBarChart({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      width: 500,
      child: BarChart(
        BarChartData(
          barGroups: stats
              .map((stat) => BarChartGroupData(
                    x: stats.indexOf(stat),
                    barRods: [
                      BarChartRodData(
                        toY: (stat.amount ?? 0).toDouble(),
                        color: Colors.orange,
                        width: 16,
                        borderRadius: BorderRadius.circular(4),
                      )
                    ],
                  ))
              .toList(),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  return Text(value.toInt().toString());
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  int index = value.toInt();
                  if (index >= 0 && index < stats.length) {
                    return Text(
                      DateFormat('dd/MM').format(
                        DateTime.fromMillisecondsSinceEpoch(stats[index].date! * 1000),
                      ),
                      style: const TextStyle(fontSize: 10),
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
        ),
      ),
    );
  }
}
