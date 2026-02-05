import 'package:peanut_api_test/routes/logic/app_route.dart';

export 'package:go_router/go_router.dart';

class RPaths {
  const RPaths._();

  // auth
  static const login = RPath('/login');

  // dash
  static const dash = RPath('/dashboard');

  // promotions
  static const promotions = RPath('/promotions');

  // profile
  static const profile = RPath('/profile');
}
