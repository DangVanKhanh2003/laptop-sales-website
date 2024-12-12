import 'dart:convert';

import 'package:admin/model/stat.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class StatsApi {
  final _url = dotenv.get('STATS_LINK');

  Future<List<Stat>> getStatsDetail({
    required int startTime,
    required int endTime,
  }) async {
    final uri = Uri.parse('$_url?startDate=$startTime&endDate=$endTime');
    final response = await http.get(uri).timeout(
          const Duration(seconds: 10),
        );
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List<dynamic>).map((e) => Stat.fromJson(e)).toList();
    }
    throw Exception('Không thể lấy được thống kê: ${response.body}');
  }
}
