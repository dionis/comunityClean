import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entitie/garbage.dart';
import '../../domain/repository/client_garbage_repository.dart';
import '../datasource/remote/remote_client_datasource.dart';
import '../models/garbage_model.dart';

class ClientGarbageRepositoryImpl implements ClientGarbageRepository {
  const ClientGarbageRepositoryImpl(
      {required RemoteClientDatasource datasource})
      : _datasource = datasource;
  final RemoteClientDatasource _datasource;
  @override
  Future<Either<Failure, Garbage>> addGarbageRequest(
      GarbageModel garbage) async {
    try {
      final data = await _datasource.addGarbageRequest(garbage);
      return Right(data);
    } on ConexionException {
      return Left(ConexionFailure());
    }
  }

  @override
  Future<Either<Failure, List<Garbage>>> getAllGarbageRequest(String id) async {
    try {
      final data = await _datasource.getAllGarbage(id);
      return Right(data);
    } on ConexionException {
      return Left(ConexionFailure());
    }
  }
}
