import 'package:admin/api/stats_api.dart';
import 'package:admin/model/stat.dart';

class StatsRepository {
  final StatsApi _statsApi;

  const StatsRepository(this._statsApi);

  Future<List<Stat>> getStatsDetail({
    required int startTime,
    required int endTime,
  }) async {
    return await _statsApi.getStatsDetail(
      startTime: startTime,
      endTime: endTime,
    );
  }
}
