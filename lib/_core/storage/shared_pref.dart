import 'package:shared_pref_annotation/shared_pref_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Short hand for [SharedPreferences]
typedef SP = SharedPreferences;

@SharedPref()
class AppPref {
  String? token;
  String? loginCode;
  String? password;
}
