import 'package:flutter/material.dart';
import 'package:peanut_api_test/main.export.dart';

class AppRoot extends HookConsumerWidget {
  const AppRoot({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ToastOverlay(child: child);
  }
}
