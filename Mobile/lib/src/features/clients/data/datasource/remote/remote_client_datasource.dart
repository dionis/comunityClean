import '../../../domain/entitie/garbage.dart';
import '../../models/garbage_model.dart';

abstract class RemoteClientDatasource {
  Future<List<Garbage>> getAllGarbage(String id);
  Future<Garbage> addGarbageRequest(GarbageModel garbage);
}
