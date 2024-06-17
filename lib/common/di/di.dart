import 'package:get_it/get_it.dart';

import '../../layers/data/ repository/auth_repository_imp.dart';
import '../../layers/data/ repository/ghealth/ghealth_repository_imp.dart';
import '../../layers/domain/repository/auth_repository.dart';
import '../../layers/domain/repository/ghealth_repository.dart';


/// getIt, inject, locator
final locator = GetIt.instance;

initLocator() {
   locator.registerLazySingleton<AuthRepository>(() => AuthRepositoryImp());
   locator.registerLazySingleton<GHealthRepository>(() => GHealthRepositoryImp());
}
