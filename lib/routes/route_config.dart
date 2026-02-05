import 'dart:async';

import 'package:flutter/material.dart';
import 'package:post_wagens/app_root.dart';
import 'package:post_wagens/features/auth/controller/auth_ctrl.dart';
import 'package:post_wagens/features/auth/view/auth_verification_view.dart';
import 'package:post_wagens/features/auth/view/login_view.dart';
import 'package:post_wagens/features/auth/view/reset_password_view.dart';
import 'package:post_wagens/features/auth/view/sign_up_view.dart';
import 'package:post_wagens/features/chat/view/chat_view.dart';
import 'package:post_wagens/features/home/view/home_view.dart';
import 'package:post_wagens/features/onboarding/view/welcome_view.dart';
import 'package:post_wagens/features/profile/view/profile_view.dart';
import 'package:post_wagens/features/search/view/search_view.dart';
import 'package:post_wagens/features/settings/view/language_view.dart';
import 'package:post_wagens/navigation/nav_root.dart';

import '../features/auth/view/check_email_view.dart';
import '../main.export.dart';

typedef RouteRedirect = FutureOr<String?> Function(BuildContext, GoRouterState);
String rootPath = RPaths.welcome.path;
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
    AppRoute(RPaths.welcome, (_) => const WelcomeView()),

    //! auth
    AppRoute(RPaths.login, (_) => const LoginView()),
    AppRoute(RPaths.signUp, (_) => const SignUpView()),
    AppRoute(RPaths.resetPassword, (_) => const ResetPasswordView()),
    AppRoute(RPaths.checkEmail, (_) => const CheckEmailView()),
    AppRoute(RPaths.authVerification, (_) => const AuthVerificationView()),

    AppRoute(RPaths.language, (_) => const LanguageView()),

    ShellRoute(
      navigatorKey: _shellNavigator,
      builder: (_, s, child) => NavigationRoot(child, key: s.pageKey),
      routes: [
        AppRoute(RPaths.home, (_) => const HomeView()),
        AppRoute(RPaths.search, (_) => const SearchView()),
        AppRoute(RPaths.chat, (_) => const ChatView()),
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

      // if (!isLoggedIn) {
      //   cat('NOT LOGGED IN', 'route');
      //   if (current.contains(RPaths.login.path)) return null;
      //   return RPaths.login.path;
      // }

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
