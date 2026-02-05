import 'package:peanut_api_test/main.export.dart';
import 'package:screwdriver/screwdriver.dart';

class AuthRepo with ApiHandler {
  final _sp = locate<SP>();

  bool isLoggedIn() => _sp.token.value != null && _sp.token.value!.isNotEmpty;

  FutureReport<bool> login(QMap data) async {
    return await handle(
      call: () => client.post(Endpoints.login, data: data),
      mapper: (map) {
        if (map case {'result': final bool result, 'token': final String token}) {
          if (result && token.isNotBlank) {
            _setToken(token);
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

  Future<bool> _setToken(String? token) async {
    if (token == null) return _sp.token.remove();
    return _sp.token.setValue(token);
  }
}
