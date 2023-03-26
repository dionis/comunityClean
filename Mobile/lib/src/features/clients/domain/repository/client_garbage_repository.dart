import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/garbage_model.dart';
import '../entitie/garbage.dart';

abstract class ClientGarbageRepository {
  Future<Either<Failure, Garbage>> addGarbageRequest(GarbageModel garbage);
  Future<Either<Failure, List<Garbage>>> getAllGarbageRequest(String id);
}
