import 'dart:async';

import 'package:flutter/material.dart';
import 'package:peanut_api_test/app_root.dart';
import 'package:peanut_api_test/features/auth/controller/auth_ctrl.dart';
import 'package:peanut_api_test/features/auth/view/login_view.dart';
import 'package:peanut_api_test/features/dashboard/view/dashboard_view.dart';
import 'package:peanut_api_test/features/profile/view/profile_view.dart';
import 'package:peanut_api_test/features/promotion/view/promotion_view.dart';
import 'package:peanut_api_test/features/trade/view/trade_view.dart';
import 'package:peanut_api_test/main.export.dart';
import 'package:peanut_api_test/navigation/nav_root.dart';

typedef RouteRedirect = FutureOr<String?> Function(BuildContext, GoRouterState);
String rootPath = RPaths.dash.path;
final routerProvider = NotifierProvider<AppRouter, GoRouter>(AppRouter.new);

class AppRouter extends Notifier<GoRouter> {
  final _rootNavigator = GlobalKey<NavigatorState>(debugLabel: 'root');
  final _shellNavigator = GlobalKey<NavigatorState>(debugLabel: 'shell');

  GoRouter _appRouter(RouteRedirect? redirect) {
    return GoRouter(
      navigatorKey: _rootNavigator,
      redirect: redirect,
      initialLocation: rootPath,
      routes: [
        ShellRoute(
          routes: _routes,
          builder: (_, s, c) => AppRoot(key: s.pageKey, child: c),
        ),
      ],
      errorBuilder: (_, state) => ErrorRoutePage(error: state.error?.message),
    );
  }

  /// The app router list
  List<RouteBase> get _routes => [
    //! auth
    AppRoute(RPaths.login, (_) => const LoginView()),

    AppRoute(RPaths.trades, (_) => const TradeView()),

    ShellRoute(
      navigatorKey: _shellNavigator,
      builder: (_, s, child) => NavigationRoot(child, key: s.pageKey),
      routes: [
        AppRoute(RPaths.dash, (_) => const DashboardView()),
        AppRoute(RPaths.promotions, (_) => const PromotionView()),
        AppRoute(RPaths.profile, (_) => const ProfileView()),
      ],
    ),
  ];

  @override
  GoRouter build() {
    Ctx._key = _rootNavigator;

    final isLoggedIn = ref.watch(authCtrlProvider);

    FutureOr<String?> redirectLogic(ctx, GoRouterState state) async {
      final current = state.uri.toString();
      cat(current, 'route redirect');

      if (!isLoggedIn) {
        cat('NOT LOGGED IN', 'route');
        if (current.contains(RPaths.login.path)) return null;
        return RPaths.login.path;
      }

      return null;
    }

    return _appRouter(redirectLogic);
  }
}

class Ctx {
  const Ctx._();
  static GlobalKey<NavigatorState>? _key;
  static BuildContext? get tryContext => _key?.currentContext;

  static BuildContext get context {
    if (_key?.currentContext == null) throw Exception('No context found');
    return _key!.currentContext!;
  }
}
