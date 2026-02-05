import 'package:peanut_api_test/main.export.dart';
import 'package:peanut_api_test/models/user/account_info_model.dart';

class ProfileRepo with ApiHandler {
  FutureReport<AccountInfoModel> getAccountInfo() async {
    return await handle(
      call: () => client.post(Endpoints.accountInformation, data: getAuthData()),
      mapper: (map) => AccountInfoModel.fromMap(map),
    );
  }

  FutureReport<String?> getLast4Digits() async {
    return await handleRaw(
      call: () => client.post(Endpoints.lastFourNumber, data: getAuthData()),
      mapper: (data) {
        if (data case final String number) return number;
        return null;
      },
    );
  }
}
