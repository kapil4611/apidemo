import 'package:apidemo/network/dio_client.dart';
import 'package:apidemo/presentation/bloc/user/user_bloc.dart';
import 'package:apidemo/repository/user_repository.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initDI() async {
  // Api Client
  sl.registerLazySingleton(() => DioClient(baseUrl: "https://reqres.in/api"));

  // Repository
  sl.registerLazySingleton(() => UserRepository(sl()));

  // BLoC
  sl.registerFactory(() => UserBloc(sl()));
}
