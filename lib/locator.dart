import 'package:get_it/get_it.dart';
import 'package:post_wagens/features/auth/repository/auth_repo.dart';

import 'main.export.dart';


final locate = GetIt.instance;

Future<void> initDependencies() async {
  final sp = await SP.getInstance();

  locate.registerSingletonIfAbsent<SP>(() => sp);

  locate.registerSingletonIfAbsent<DioClient>(() => DioClient());
  locate.registerSingletonIfAbsent<AuthRepo>(() => AuthRepo());
}
