import 'package:city_clean/src/core/network/network_info.dart';
import 'package:city_clean/src/features/clients/domain/usecases/upload_image.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../features/clients/data/datasource/remote/dio_remote_client_datasource.dart';
import '../../features/clients/data/datasource/remote/remote_client_datasource.dart';
import '../../features/clients/data/repository/client_garbage_repository_impl.dart';
import '../../features/clients/domain/repository/client_garbage_repository.dart';
import '../../features/clients/domain/usecases/add_garbage_request.dart';
import '../../features/clients/domain/usecases/dalete_garbage_request.dart';
import '../../features/clients/domain/usecases/get_all_garbage_request.dart';
import '../../features/clients/domain/usecases/update_garbage_request.dart';
import '../../features/clients/presentation/bloc/client_bloc.dart';

class DependencyInyection {
  static final sl = GetIt.instance;

  static Future<void> init() async {
    // Bloc
    sl.registerFactory(() => ClientBloc(
        addGarbageRequestUse: sl(),
        getAllGarbageRequestUse: sl(),
        uploadImage: sl(),
        deleteGarbageRequest: sl(),
        updateGarbageRequest: sl()));

    // UseCases
    sl.registerLazySingleton(() => GetAllGarbageRequest(repository: sl()));
    sl.registerLazySingleton(() => AddGarbageRequest(repository: sl()));
    sl.registerLazySingleton(() => DeleteGarbageRequest(repository: sl()));
    sl.registerLazySingleton(() => UploadImage(repository: sl()));
    sl.registerLazySingleton(() => UpdateGarbageRequest(repository: sl()));

    // Repository
    sl.registerLazySingleton<ClientGarbageRepository>(
        () => ClientGarbageRepositoryImpl(datasource: sl()));

    // Datasources
    sl.registerLazySingleton<RemoteClientDatasource>(() =>
        DioRemoteClientDatasource(
            url: 'https://srv37158-15190.vps.etecsa.cu/api/v1/requests/',
            client: sl()));

    // Core
    sl.registerLazySingleton<NetworkInfo>(
        () => NetwotkInfoImpl(connection: sl()));

    // External
    sl.registerLazySingleton(() => Dio());
    sl.registerLazySingleton(() => InternetConnectionChecker());
  }
}
