import 'package:admin/screen/dashboard/dashboard_analysis.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late DateTime _startTime;
  late DateTime _endTime;

  @override
  void initState() {
    _startTime = DateTime.now();
    _endTime = DateTime.now();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _pickStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startTime,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _startTime) {
      setState(() {
        _startTime = picked;
      });
    }
  }

  void _pickEndDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _endTime,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _endTime) {
      setState(() {
        _endTime = picked;
      });
    }
  }

  String _formatDate(DateTime date) {
    final formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(date);
  }

  Widget _datePickerRow({
    required String label,
    required DateTime date,
    required VoidCallback onPressed,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(label),
            const SizedBox(width: 8.0),
            IconButton(
              icon: const Icon(Icons.calendar_month, color: Colors.blue),
              onPressed: onPressed,
            ),
            const SizedBox(width: 8.0),
            Text(
              _formatDate(date),
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _searchButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DashboardAnalysis(
              endTime: _endTime,
              startTime: _startTime,
            ),
          ),
        );
      },
      child: const SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.0),
          child: Center(child: Text('Thống kê')),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _datePickerRow(
            label: 'Thời gian bắt đầu: ',
            date: _startTime,
            onPressed: _pickStartDate,
          ),
          const SizedBox(height: 8.0),
          _datePickerRow(
            label: 'Thời gian kết thúc: ',
            date: _endTime,
            onPressed: _pickEndDate,
          ),
          const SizedBox(height: 4.0),
          _searchButton(),
        ],
      ),
    );
  }
}
