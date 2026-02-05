import 'package:peanut_api_test/main.export.dart';
import 'package:screwdriver/screwdriver.dart';

class AuthRepo with ApiHandler {
  final _sp = locate<SP>();

  bool isLoggedIn() => _sp.token.value != null && _sp.token.value!.isNotEmpty;

  FutureReport<bool> login(QMap data) async {
    return await handle(
      call: () => client.post(Endpoints.login, data: data),
      mapper: (map) async {
        if (map case {'result': final bool result, 'token': final String token}) {
          if (result && token.isNotBlank) {
            await _setToken(token, data['login']);

            return true;
          }
        }
        throw const Failure('Unable to login. Check your credentials.');
      },
    );
  }

  Future<bool> logout() async {
    return _setToken(null, null);
  }

  Future<bool> _setToken(String? token, String? code) async {
    if (token == null) return _sp.token.remove();
    if (code != null) await _sp.loginCode.setValue(code);
    return _sp.token.setValue(token);
  }
}
