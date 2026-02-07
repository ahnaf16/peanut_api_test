import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:peanut_api_test/features/auth/controller/auth_ctrl.dart';
import 'package:peanut_api_test/features/connectivity/controller/connectivity_ctrl.dart';
import 'package:peanut_api_test/features/connectivity/view/no_internet_dialog.dart';
import 'package:peanut_api_test/main.export.dart';

class AppRoot extends HookConsumerWidget {
  const AppRoot({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(connectivityProvider, (previous, next) {
      final status = next.value;
      if (status != null && status.isNotEmpty && status.contains(ConnectivityResult.none)) {
        _showNoInternetDialog(context);
      } else {
        if (Navigator.of(context).canPop()) context.nPop();
      }
    });

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

  void _showNoInternetDialog(BuildContext context) {
    showDialog(context: context, barrierDismissible: false, builder: (context) => const NoInternetDialog());
  }
}
