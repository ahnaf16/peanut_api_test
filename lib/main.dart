import 'package:flutter/material.dart';

import 'main.export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: kAppName,
      theme: KAppTheme.appTheme(false),
      darkTheme: KAppTheme.appTheme(true),
      themeMode: ThemeMode.light,
      routerConfig: route,
    );
  }
}
