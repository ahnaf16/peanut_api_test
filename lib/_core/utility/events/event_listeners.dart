import 'package:post_wagens/main.export.dart';

final loggedOutEvProvider = StreamProvider<LoggedOutEv>((ref) async* {
  yield* EvBus.instance.onLogoutEv();
});
