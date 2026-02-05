import 'package:peanut_api_test/features/trade/repository/trade_repo.dart';
import 'package:peanut_api_test/main.export.dart';
import 'package:peanut_api_test/models/trade/trade_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'trade_ctrl.g.dart';

@riverpod
class TradeCtrl extends _$TradeCtrl {
  final _repo = locate<TradeRepo>();
  @override
  FutureOr<List<TradeModel>> build() async {
    final res = await _repo.getTrades();
    return res.fold((l) {
      return Future.error('Unable to fetch trades.');
    }, (r) => r);
  }
}
