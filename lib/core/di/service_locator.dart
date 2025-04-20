import 'package:get_it/get_it.dart';
import '../../providers/auth_provider.dart';
import '../../services/AuthService.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  //register services
  getIt.registerLazySingleton<AuthService>(() => AuthService());


  // Register providers (use the service)
  getIt.registerLazySingleton<AuthProvider>(
        () => AuthProvider(getIt<AuthService>()),
  );



}
