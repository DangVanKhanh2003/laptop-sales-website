import 'package:shopping_app/api/history_api.dart';
import 'package:shopping_app/model/history.dart';
import 'package:shopping_app/model/token_state.dart';

class HistoryRepository {
  final HistoryApi _historyApi;
  HistoryRepository(this._historyApi);

  Future<List<HistorySuccess>> getSuccessHistory({
    required TokenState token,
    required int customerId,
  }) async {
    return await _historyApi.getSuccessHistory(
      token: token,
      customerId: customerId,
    );
  }

  Future<List<HistoryCancel>> getCancelHistory({
    required TokenState token,
    required int customerId,
  }) async {
    return await _historyApi.getCancelHistory(
      token: token,
      customerId: customerId,
    );
  }
}
