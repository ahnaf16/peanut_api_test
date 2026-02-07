// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion_ctrl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PromotionCtrl)
final promotionCtrlProvider = PromotionCtrlProvider._();

final class PromotionCtrlProvider
    extends $AsyncNotifierProvider<PromotionCtrl, List<PromoModel>> {
  PromotionCtrlProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'promotionCtrlProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$promotionCtrlHash();

  @$internal
  @override
  PromotionCtrl create() => PromotionCtrl();
}

String _$promotionCtrlHash() => r'1af9718115117ae46f08305f89886603219b1637';

abstract class _$PromotionCtrl extends $AsyncNotifier<List<PromoModel>> {
  FutureOr<List<PromoModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<PromoModel>>, List<PromoModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<PromoModel>>, List<PromoModel>>,
              AsyncValue<List<PromoModel>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
