import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entitie/garbage.dart';
import '../repository/client_garbage_repository.dart';

class GetAllGarbageRequest {
  const GetAllGarbageRequest({required ClientGarbageRepository repository})
      : _repository = repository;
  final ClientGarbageRepository _repository;

  Future<Either<Failure, List<Garbage>>> call({required String id}) async =>
      await _repository.getAllGarbageRequest(id);
}
