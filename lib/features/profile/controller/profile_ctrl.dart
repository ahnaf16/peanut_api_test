import 'package:peanut_api_test/features/profile/repository/profile_repo.dart';
import 'package:peanut_api_test/features/trade/controller/trade_ctrl.dart';
import 'package:peanut_api_test/main.export.dart';
import 'package:peanut_api_test/models/user/account_info_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_ctrl.g.dart';

@riverpod
class AccountInfoCtrl extends _$AccountInfoCtrl {
  final _repo = locate<ProfileRepo>();
  @override
  FutureOr<AccountInfoModel> build() async {
    final res = await _repo.getAccountInfo();
    return res.fold((l) {
      return Future.error('Unable to fetch account info.');
    }, (r) => r);
  }
}

@riverpod
class PhoneDigitCtrl extends _$PhoneDigitCtrl {
  final _repo = locate<ProfileRepo>();
  @override
  FutureOr<String?> build() async {
    final res = await _repo.getLast4Digits();
    return res.fold((l) => null, (r) => r);
  }
}

@riverpod
double totalTradesProfit(Ref ref) {
  final tradesAsync = ref.watch(tradeCtrlProvider);
  return tradesAsync.maybeWhen(
    data: (trades) => trades.fold(0.0, (sum, trade) => sum + trade.profit.toDouble()),
    orElse: () => 0.0,
  );
}
