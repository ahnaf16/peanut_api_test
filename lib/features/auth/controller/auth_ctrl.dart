import 'package:flutter_animate/flutter_animate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:post_wagens/features/auth/repository/auth_repo.dart';
import 'package:post_wagens/main.export.dart';

part 'auth_ctrl.g.dart';

@Riverpod(keepAlive: true)
class AuthCtrl extends _$AuthCtrl {
  final _repo = locate<AuthRepo>();

  @override
  bool build() {
    return _repo.isLoggedIn();
  }

  FVoid login(QMap data) async {
    await Future.delayed(2.seconds);
    await _repo.login(data);
    ref.invalidateSelf();
    return;
  }

  FVoid signUp(QMap data) async {
    await Future.delayed(2.seconds);
    await _repo.signUp(data);
    ref.invalidateSelf();
    return;
  }

  FVoid logout() async {
    await Future.delayed(2.seconds);
    await _repo.logout();
    ref.invalidateSelf();
    return;
  }
}
