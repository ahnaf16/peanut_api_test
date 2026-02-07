import 'package:peanut_api_test/main.export.dart';
import 'package:screwdriver/screwdriver.dart';

class AuthRepo with ApiHandler {
  final _sp = locate<SP>();

  bool isLoggedIn() => _sp.token.value != null && _sp.token.value!.isNotEmpty;

  FutureReport<bool> login(QMap data, bool remember) async {
    return await handle(
      call: () => client.post(Endpoints.login, data: data),
      mapper: (map) async {
        if (!remember) await _removeSaved();
        if (map case {'result': final bool result, 'token': final String token}) {
          if (result && token.isNotBlank) {
            await _setToken(token, data['login'], remember ? data['password'] : null);

            return true;
          }
        }
        throw const Failure('Unable to login. Check your credentials.');
      },
    );
  }

  Future<bool> logout() async {
    return _setToken(null);
  }

  Map<String, String> savedLoginData() {
    return {'login': ?_sp.loginCode.value, 'password': ?_sp.password.value};
  }

  Future<bool> _setToken(String? token, [String? code, String? pass]) async {
    if (token == null) return _sp.token.remove();
    if (code != null) await _sp.loginCode.setValue(code);
    if (pass != null) await _sp.password.setValue(pass);
    return _sp.token.setValue(token);
  }

  Future<void> _removeSaved() async {
    await Future.wait([_sp.loginCode.remove(), _sp.password.remove()]);
  }
}
