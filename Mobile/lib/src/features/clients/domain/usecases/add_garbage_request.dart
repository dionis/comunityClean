import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/garbage_model.dart';
import '../entitie/garbage.dart';
import '../repository/client_garbage_repository.dart';

class AddGarbageRequest {
  const AddGarbageRequest({required ClientGarbageRepository repository})
      : _repository = repository;

  final ClientGarbageRepository _repository;

  Future<Either<Failure, Garbage>> call(
          {required GarbageModel garbage}) async =>
      await _repository.addGarbageRequest(garbage);
}
