import 'package:get_it/get_it.dart';
import '../../services/AuthService.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<AuthService>(() => AuthService());
}
