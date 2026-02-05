import 'package:peanut_api_test/routes/logic/app_route.dart';

export 'package:go_router/go_router.dart';

class RPaths {
  const RPaths._();
  static const welcome = RPath('/welcome');

  // auth
  static const login = RPath('/login');
  static const signUp = RPath('/sign-up');
  static const resetPassword = RPath('/reset_password');
  static const checkEmail = RPath('/check_email');
  static const resetSuccessful = RPath('/reset_successful');
  static const authVerification = RPath('/auth_verification');
  // home
  static const home = RPath('/home');
  static const notification = RPath('/notification');

  // search
  static const search = RPath('/search');

  // chat
  static const chat = RPath('/chat');

  // profile
  static const profile = RPath('/profile');
  static RPath userProfile(String id) => RPath('/user_profile/$id');
  static const settings = RPath('/settings');
  static const language = RPath('/language');
  static const editProfile = RPath('/edit_profile');

  // settings
  static const privacyPolicy = RPath('/privacy_policy');
}
