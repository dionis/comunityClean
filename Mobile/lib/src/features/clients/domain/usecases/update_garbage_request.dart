import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/garbage_model.dart';
import '../repository/client_garbage_repository.dart';

class UpdateGarbageRequest {
  const UpdateGarbageRequest({required ClientGarbageRepository repository})
      : _repository = repository;

  final ClientGarbageRepository _repository;

  Future<Either<Failure, GarbageModel>> call(
          {required GarbageModel newGarbage}) async =>
      await _repository.updateGarbageRequest(newGarbage);
}
