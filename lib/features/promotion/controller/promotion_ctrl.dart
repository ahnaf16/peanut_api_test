import 'package:peanut_api_test/features/promotion/repository/promotion_repo.dart';
import 'package:peanut_api_test/main.export.dart';
import 'package:peanut_api_test/models/promo/promo_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'promotion_ctrl.g.dart';

@riverpod
class PromotionCtrl extends _$PromotionCtrl {
  final _repo = locate<PromotionRepo>();
  @override
  FutureOr<List<PromoModel>> build() async {
    final res = await _repo.getPromos();
    return res.fold((l) => l.toFuture(), (r) => r);
  }

  FVoid refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async => build());
  }
}
