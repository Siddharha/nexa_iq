import 'package:get_it/get_it.dart';
// import 'data/repositories_impl/user_repository_impl.dart';
// import 'domain/repositories/user_repository.dart';
// import 'domain/usecases/get_user.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // // Usecases
  // sl.registerLazySingleton(() => GetUser(sl()));

  // // Repositories
  // sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl());

  // Data sources
  // sl.registerLazySingleton<UserRemoteDataSource>(() => UserRemoteDataSourceImpl());
}
