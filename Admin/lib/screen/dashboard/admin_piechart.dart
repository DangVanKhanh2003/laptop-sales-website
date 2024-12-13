import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:admin/model/stat.dart';

class AdminPieChart extends StatelessWidget {
  final List<Stat> stats;

  const AdminPieChart({
    super.key,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    final double totalMoney = stats.fold(0.0, (sum, stat) => sum + (stat.money ?? 0.0));
    return SizedBox(
      height: 500,
      width: 500,
      child: PieChart(
        PieChartData(
          sections: stats.map((stat) {
            final percentage = ((stat.money ?? 0.0) / totalMoney) * 100;
            return PieChartSectionData(
              value: percentage,
              title: '${percentage.toStringAsFixed(1)}%',
              color: Colors.primaries[stats.indexOf(stat) % Colors.primaries.length],
              radius: 50,
              titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            );
          }).toList(),
          sectionsSpace: 2,
          centerSpaceRadius: 40,
        ),
      ),
    );
  }
}
