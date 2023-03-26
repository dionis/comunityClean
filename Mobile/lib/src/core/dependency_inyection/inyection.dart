import 'package:city_clean/src/core/network/network_info.dart';
import 'package:city_clean/src/features/clients/data/datasource/remote/dio_remote_client_datasource.dart';
import 'package:city_clean/src/features/clients/data/datasource/remote/remote_client_datasource.dart';
import 'package:city_clean/src/features/clients/data/repository/client_garbage_repository_impl.dart';
import 'package:city_clean/src/features/clients/domain/repository/client_garbage_repository.dart';
import 'package:city_clean/src/features/clients/domain/usecases/add_garbage_request.dart';
import 'package:city_clean/src/features/clients/domain/usecases/get_all_garbage_request.dart';
import 'package:city_clean/src/features/clients/presentation/bloc/client_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() =>
      ClientBloc(addGarbageRequestUse: sl(), getAllGarbageRequestUse: sl()));

  // UseCases
  sl.registerLazySingleton(() => GetAllGarbageRequest(repository: sl()));
  sl.registerLazySingleton(() => AddGarbageRequest(repository: sl()));

  // Repository
  sl.registerLazySingleton<ClientGarbageRepository>(
      () => ClientGarbageRepositoryImpl(datasource: sl()));

  // Datasources
  sl.registerLazySingleton<RemoteClientDatasource>(() =>
      DioRemoteClientDatasource(
          url: 'http://localhost:8000/api/v1/requests/', client: sl()));

  // Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetwotkInfoImpl(connection: sl()));

  // External
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
