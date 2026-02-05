import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'main.export.dart';

void main() async {
  // Endpoints.testURL = 'http://192.168.1.133/qhub-360-server';
  WidgetsFlutterBinding.ensureInitialized();
  Animate.restartOnHotReload = true;

  await initDependencies();

  FlutterError.onError = (d) {
    if ('${d.summary}'.contains('package:flutter/src/rendering/mouse_tracker.dart')) return;
    FlutterError.presentError(d);
  };
  runApp(const ProviderScope(child: _App()));
}

class _App extends HookConsumerWidget {
  const _App();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final route = ref.watch(routerProvider);

    return _INITApp(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: kAppName,
        theme: KAppTheme.appTheme(false),
        darkTheme: KAppTheme.appTheme(true),
        themeMode: ThemeMode.light,
        routerConfig: route,
      ),
    );
  }
}

class _INITApp extends HookConsumerWidget {
  const _INITApp({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //! LISTENERS --------------------------
    ref.listen(loggedOutEvProvider, (_, n) {});

    //! LISTENERS --------------------------

    return child;
  }
}
