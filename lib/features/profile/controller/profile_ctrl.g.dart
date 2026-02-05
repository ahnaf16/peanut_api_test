// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_ctrl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AccountInfoCtrl)
final accountInfoCtrlProvider = AccountInfoCtrlProvider._();

final class AccountInfoCtrlProvider
    extends $AsyncNotifierProvider<AccountInfoCtrl, AccountInfoModel> {
  AccountInfoCtrlProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'accountInfoCtrlProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$accountInfoCtrlHash();

  @$internal
  @override
  AccountInfoCtrl create() => AccountInfoCtrl();
}

String _$accountInfoCtrlHash() => r'5bcb6295b24405055a3a8f70a1f20dd1343eb9e3';

abstract class _$AccountInfoCtrl extends $AsyncNotifier<AccountInfoModel> {
  FutureOr<AccountInfoModel> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<AccountInfoModel>, AccountInfoModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AccountInfoModel>, AccountInfoModel>,
              AsyncValue<AccountInfoModel>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(PhoneDigitCtrl)
final phoneDigitCtrlProvider = PhoneDigitCtrlProvider._();

final class PhoneDigitCtrlProvider
    extends $AsyncNotifierProvider<PhoneDigitCtrl, String?> {
  PhoneDigitCtrlProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'phoneDigitCtrlProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$phoneDigitCtrlHash();

  @$internal
  @override
  PhoneDigitCtrl create() => PhoneDigitCtrl();
}

String _$phoneDigitCtrlHash() => r'855b8582724d623457a7a4d095ad38da0d2d326c';

abstract class _$PhoneDigitCtrl extends $AsyncNotifier<String?> {
  FutureOr<String?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<String?>, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<String?>, String?>,
              AsyncValue<String?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
