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
  Future<Garbage> addGarbageRequest(GarbageModel garbage, int id) async {
    try {
      Map data = garbage.toJson();
      data['userId'] = id;
      final results = await _client.post(_url, data: data);
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
      final request = await _client.get('${_url}user/$id');
      if (request.statusCode == 200) {
        for (var i = 0; i < request.data.length; i++) {
          final element = request.data[i];
          listGarbage.add(GarbageModel.fromJson(element));
        }
        return listGarbage;
      } else {
        throw ConexionException();
      }
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
        return GarbageModel.fromJson(results.data[0]);
      }
      throw ConexionException();
    } catch (e) {
      throw ConexionException();
    }
  }

  @override
  Future<String> uploadImage(String path) async {
    try {
      final formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(path),
      });
      String baseUrl = 'https://srv37158-15190.vps.etecsa.cu';
      final response = await _client.post('$baseUrl/upload', data: formData);

      if (response.statusCode == 200) {
        return '$baseUrl${response.data["fileUrl"]}';
      } else {
        throw ConexionException();
      }
    } catch (e) {
      throw ConexionException();
    }
  }
}
