import 'package:city_clean/src/features/clients/data/datasource/remote/remote_client_datasource.dart';
import 'package:dio/dio.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../domain/entitie/garbage.dart';
import '../../models/garbage_model.dart';

class DioRemoteClientDatasource implements RemoteClientDatasource {
  const DioRemoteClientDatasource({required String url, required Dio client})
      : _client = client,
        _url = url;
  final String _url;
  final Dio _client;

  @override
  Future<Garbage> addGarbageRequest(GarbageModel garbage) async {
    try {
      final results = await _client.post(_url, data: garbage.toJson());
      if (results.statusCode == 200) {
        return GarbageModel.fromJson(results.data);
      }
      throw ConexionException();
    } catch (e) {
      throw ConexionException();
    }
  }

  @override
  Future<List<Garbage>> getAllGarbage(String id) async {
    try {
      List<Garbage> listGarbage = [];
      final results = await _client.get('$_url$id');
      if (results.statusCode == 200) {
        for (var i = 0; i < results.data.length; i++) {
          final element = results.data[i];
          listGarbage.add(GarbageModel.fromJson(element));
        }
        return listGarbage;
      }
      throw ConexionException();
    } catch (e) {
      throw ConexionException();
    }
  }

  @override
  Future<bool> deleteGarbageRequest(String id) async {
    try {
      final results = await _client.delete('$_url$id');
      if (results.statusCode == 200) {
        return true;
      }
      throw ConexionException();
    } catch (e) {
      throw ConexionException();
    }
  }

  @override
  Future<GarbageModel> updateGarbageRequest(GarbageModel newGarbage) async {
    try {
      final results =
          await _client.put('$_url${newGarbage.id}', data: newGarbage.toJson());
      if (results.statusCode == 200) {
        return GarbageModel.fromJson(results.data);
      }
      throw ConexionException();
    } catch (e) {
      throw ConexionException();
    }
  }
}
