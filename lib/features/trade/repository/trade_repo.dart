import 'package:peanut_api_test/main.export.dart';
import 'package:peanut_api_test/models/trade/trade_model.dart';

class TradeRepo with ApiHandler {
  FutureReport<List<TradeModel>> getTrades() async {
    return await handleRaw(
      call: () => client.post(Endpoints.trades, data: getAuthData()),
      mapper: (data) {
        if (data case final List list) {
          return list.map((e) => TradeModel.fromMap(e)).toList();
        } else {
          return [];
        }
      },
    );
  }
}
