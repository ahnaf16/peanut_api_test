// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade_ctrl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TradeCtrl)
final tradeCtrlProvider = TradeCtrlProvider._();

final class TradeCtrlProvider
    extends $AsyncNotifierProvider<TradeCtrl, List<TradeModel>> {
  TradeCtrlProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tradeCtrlProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tradeCtrlHash();

  @$internal
  @override
  TradeCtrl create() => TradeCtrl();
}

String _$tradeCtrlHash() => r'e50663995dfcd043c6c3c782d9e581108fcd9ec6';

abstract class _$TradeCtrl extends $AsyncNotifier<List<TradeModel>> {
  FutureOr<List<TradeModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<TradeModel>>, List<TradeModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<TradeModel>>, List<TradeModel>>,
              AsyncValue<List<TradeModel>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
