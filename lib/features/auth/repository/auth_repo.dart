import 'package:post_wagens/main.export.dart';

class AuthRepo with ApiHandler {
  final _sp = locate<SP>();

  bool isLoggedIn() => true;

  Future<bool> login(QMap data) async {
    return _setToken('MOCK_TOKEN');
  }

  Future<bool> signUp(QMap data) async {
    return _setToken('MOCK_TOKEN');
  }

  Future<bool> logout() async {
    return _setToken(null);
  }

  Future<bool> _setToken(String? token) async {
   return true;
  }
}
