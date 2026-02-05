import 'package:flutter/material.dart';
import 'package:peanut_api_test/features/auth/controller/auth_ctrl.dart';
import 'package:peanut_api_test/main.export.dart';

class AppRoot extends HookConsumerWidget {
  const AppRoot({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      final sub = EvBus.instance.onLogoutEv().listen((ev) {
        ref.read(authCtrlProvider.notifier).logout();
      });
      return () {
        sub.cancel();
      };
    }, const []);
    return ToastOverlay(child: child);
  }
}
