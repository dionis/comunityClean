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
      GarbageModel garbage, int id) async {
    try {
      final data = await _datasource.addGarbageRequest(garbage, id);
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

  @override
  Future<Either<Failure, bool>> deleteGarbageRequest(String id) async {
    try {
      final data = await _datasource.deleteGarbageRequest(id);
      return Right(data);
    } on ConexionException {
      return Left(ConexionFailure());
    }
  }

  @override
  Future<Either<Failure, GarbageModel>> updateGarbageRequest(
      GarbageModel newGarbage) async {
    try {
      final data = await _datasource.updateGarbageRequest(newGarbage);
      return Right(data);
    } on ConexionException {
      return Left(ConexionFailure());
    }
  }

  @override
  Future<Either<Failure, String>> uploadImage(String path) async {
    try {
      final data = await _datasource.uploadImage(path);
      return Right(data);
    } on ConexionException {
      return Left(ConexionFailure());
    }
  }
}
