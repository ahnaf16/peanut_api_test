import 'package:peanut_api_test/main.export.dart';

final loggedOutEvProvider = StreamProvider<LoggedOutEv>((ref) async* {
  yield* EvBus.instance.onLogoutEv();
});
