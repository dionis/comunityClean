import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/garbage_model.dart';
import '../entitie/garbage.dart';

abstract class ClientGarbageRepository {
  Future<Either<Failure, Garbage>> addGarbageRequest(
      GarbageModel garbage, int id);
  Future<Either<Failure, List<Garbage>>> getAllGarbageRequest(String id);
  Future<Either<Failure, bool>> deleteGarbageRequest(String id);
  Future<Either<Failure, String>> uploadImage(String path);
  Future<Either<Failure, GarbageModel>> updateGarbageRequest(
      GarbageModel newGarbage);
}
