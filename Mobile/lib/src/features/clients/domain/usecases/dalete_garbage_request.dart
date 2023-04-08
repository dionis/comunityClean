import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repository/client_garbage_repository.dart';

class DeleteGarbageRequest {
  const DeleteGarbageRequest({required ClientGarbageRepository repository})
      : _repository = repository;
  final ClientGarbageRepository _repository;

  Future<Either<Failure, bool>> call({required String id}) async =>
      await _repository.deleteGarbageRequest(id);
}
