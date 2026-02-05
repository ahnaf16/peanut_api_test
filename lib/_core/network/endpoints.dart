import 'package:flutter/foundation.dart';
import 'package:peanut_api_test/main.export.dart';

extension type const EndPoint(String value) implements String {
  String queryParams(SMap query) {
    return '$this?${query.entries.map((e) => '${e.key}=${e.value}').join('&')}';
  }

  String get name => replaceAll('/', '');
}

class Endpoints {
  Endpoints._();

  static String? testURL;
  static bool get isTestUrl => testURL != null && !kReleaseMode;

  // base url
  static const String _baseUrl = 'https://peanut.ifxdb.com';
  static const String _apiSuffix = 'api/ClientCabinetBasic';

  static String get _host => '${isTestUrl ? testURL : _baseUrl}';

  static String get clientApi => '$_host/$_apiSuffix/';

  static EndPoint get login => const EndPoint('IsAccountCredentialsCorrect');
  static EndPoint get accountInformation => const EndPoint('GetAccountInformation');
  static EndPoint get lastFourNumber => const EndPoint('GetLastFourNumbersPhone');
  static EndPoint get trades => const EndPoint('GetOpenTrades');
}
