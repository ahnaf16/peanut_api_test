import 'package:peanut_api_test/features/auth/repository/auth_repo.dart';
import 'package:peanut_api_test/main.export.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_ctrl.g.dart';

@Riverpod(keepAlive: true)
class AuthCtrl extends _$AuthCtrl {
  final _repo = locate<AuthRepo>();

  @override
  bool build() {
    return _repo.isLoggedIn();
  }

  FVoid login(QMap data, bool remember) async {
    final res = await _repo.login(data, remember);
    res.fold((l) => toaster.showError('Login Failed', message: l.msg), (r) => ref.invalidateSelf());
    return;
  }

  Map<String, String> getSavedLoginData() {
    return _repo.savedLoginData();
  }

  FVoid logout() async {
    await _repo.logout();
    ref.invalidateSelf();
  }
}
