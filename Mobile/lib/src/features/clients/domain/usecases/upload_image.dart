import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repository/client_garbage_repository.dart';

class UploadImage {
  const UploadImage({required ClientGarbageRepository repository})
      : _repository = repository;

  final ClientGarbageRepository _repository;

  Future<Either<Failure, String>> call({required String path}) async =>
      await _repository.uploadImage(path);
}
