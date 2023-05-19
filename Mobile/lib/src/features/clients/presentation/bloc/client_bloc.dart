import 'dart:async';

import 'package:city_clean/src/features/clients/domain/usecases/dalete_garbage_request.dart';
import 'package:city_clean/src/features/clients/domain/usecases/update_garbage_request.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../data/models/garbage_model.dart';
import '../../domain/entitie/garbage.dart';
import '../../domain/usecases/add_garbage_request.dart';
import '../../domain/usecases/get_all_garbage_request.dart';
import '../../domain/usecases/upload_image.dart';

part 'client_event.dart';
part 'client_state.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  ClientBloc(
      {required AddGarbageRequest addGarbageRequestUse,
      required GetAllGarbageRequest getAllGarbageRequestUse,
      required DeleteGarbageRequest deleteGarbageRequest,
      required UploadImage uploadImage,
      required UpdateGarbageRequest updateGarbageRequest})
      : _addGarbageRequestUse = addGarbageRequestUse,
        _getAllGarbageRequestUse = getAllGarbageRequestUse,
        _deleteGarbageRequestUse = deleteGarbageRequest,
        _uploadImage = uploadImage,
        _updateGarbageRequest = updateGarbageRequest,
        super(ClientState.initialState()) {
    on<_ChangeDotsEvent>(_changeDotsEvent);
    on<_ChangeIndexEvent>(_changeIndexEvent);
    on<_GetAllGarbageRequest>(_getAllGarbageRequest);
    on<_AddGarbageRequest>(_addGarbageRequest);
    on<_UpdateNewGarbage>(_updateNewGarbage);
    on<_ResetNewGarbage>(_resetNewGarbage);
    on<_SubmitNewGarbage>(_submitNewGarbage);
    on<_DeleteGarbage>(_deleteGarbageRequest);
    on<_UpdatePosition>(_updatePosition);
    on<_UpdateGarbage>(_updateGarbage);
    on<_UpdateRequest>(_updateRequest);
    on<_UpdateImageUrl>(_updateImageUrl);
  }
  final AddGarbageRequest _addGarbageRequestUse;
  final GetAllGarbageRequest _getAllGarbageRequestUse;
  final DeleteGarbageRequest _deleteGarbageRequestUse;
  final UpdateGarbageRequest _updateGarbageRequest;
  final UploadImage _uploadImage;

  FutureOr<void> _changeIndexEvent(
      _ChangeIndexEvent event, Emitter<ClientState> emit) {
    emit(state.copyWith(index: event.index));
  }

  FutureOr<void> _changeDotsEvent(
      _ChangeDotsEvent event, Emitter<ClientState> emit) {
    emit(state.copyWith(
        dotsIndex: event.dotIndex,
        imageUrl: event.dotIndex == 0 ? '' : state.imageUrl));
  }

  FutureOr<void> _getAllGarbageRequest(
      _GetAllGarbageRequest event, Emitter<ClientState> emit) async {
    emit(state.copyWith(garbageStatus: GarbageStatus.loading));
    final results = await _getAllGarbageRequestUse(id: event.id);
    results.fold(
        (error) => emit(state.copyWith(
            garbageStatus: GarbageStatus.error,
            error: 'No tienes Conexión')), (garbages) {
      final List<Garbage> pending = [];
      final List<Garbage> complet = [];
      for (var element in garbages) {
        if (!element.stat!) {
          pending.add(element);
        } else {
          complet.add(element);
        }
      }
      emit(state.copyWith(
          garbageStatus: GarbageStatus.success,
          listCompletos: complet,
          listPendientes: pending));
    });
  }

  FutureOr<void> _addGarbageRequest(
      _AddGarbageRequest event, Emitter<ClientState> emit) async {
    emit(state.copyWith(garbageSubmit: GarbageSubmit.loading));
    final results =
        await _addGarbageRequestUse(garbage: event.garbage, id: event.id);
    results.fold(
        (error) => emit(state.copyWith(
            error: 'No tienes Conexión', garbageSubmit: GarbageSubmit.error)),
        (garbage) =>
            emit(state.copyWith(garbageSubmit: GarbageSubmit.success)));
  }

  FutureOr<void> _updateNewGarbage(
      _UpdateNewGarbage event, Emitter<ClientState> emit) {
    Map<String, dynamic> value = {...state.newGarbage};
    value[event.key] = event.value;
    emit(state.copyWith(newGarbage: value));
  }

  FutureOr<void> _resetNewGarbage(
      _ResetNewGarbage event, Emitter<ClientState> emit) {
    emit(state.copyWith(newGarbage: {}));
  }

  FutureOr<void> _submitNewGarbage(
      _SubmitNewGarbage event, Emitter<ClientState> emit) async {
    Map<String, dynamic> value = {...state.newGarbage};
    String? path;
    if (state.imageUrl.isNotEmpty) {
      final results = await _uploadImage(path: event.value);
      results.fold(
          (error) => emit(state.copyWith(
              garbageStatus: GarbageStatus.error, error: 'No tienes Conexión')),
          (value) => path = value);
    }
    if (path != null) {
      value[event.key] = path;
    } else {
      value[event.key] = event.value;
    }
    if (state.editGarbage!.id.isNotEmpty) {
      value["id"] = state.editGarbage?.id;
      emit(state.copyWith(newGarbage: value));
      final garbage = GarbageModel.fromJson(state.newGarbage);

      state.copyWith(newGarbage: {}, imageUrl: '');
      add(ClientEvent.updateRequest(newGarbage: garbage));
    } else {
      emit(state.copyWith(newGarbage: value));
      final garbage = GarbageModel.fromJson(state.newGarbage);
      state.copyWith(newGarbage: {}, imageUrl: '');
      add(ClientEvent.addGarbageRequest(garbage: garbage, id: 1));
    }
  }

  FutureOr<void> _deleteGarbageRequest(
      _DeleteGarbage event, Emitter<ClientState> emit) async {
    final results = await _deleteGarbageRequestUse(id: event.id);
    results.fold(
        (error) => emit(state.copyWith(
            garbageStatus: GarbageStatus.error, error: 'No tienes Conexión')),
        (value) => add(ClientEvent.getAllGarbageRequest(id: '1')));
  }

  FutureOr<void> _updatePosition(
      _UpdatePosition event, Emitter<ClientState> emit) {
    emit(state.copyWith(position: event.newPosition));
  }

  FutureOr<void> _updateGarbage(
      _UpdateGarbage event, Emitter<ClientState> emit) {
    emit(state.copyWith(editGarbage: event.newGarbage));
  }

  FutureOr<void> _updateRequest(
      _UpdateRequest event, Emitter<ClientState> emit) async {
    emit(state.copyWith(garbageSubmit: GarbageSubmit.loading));
    final results = await _updateGarbageRequest(newGarbage: event.newGarbage);
    results.fold(
        (error) => emit(state.copyWith(
            error: 'No tienes Conexión', garbageSubmit: GarbageSubmit.error)),
        (garbage) =>
            emit(state.copyWith(garbageSubmit: GarbageSubmit.success)));
  }

  FutureOr<void> _updateImageUrl(
      _UpdateImageUrl event, Emitter<ClientState> emit) async {
    if (await Permission.storage.request().isGranted &&
        await Permission.camera.request().isGranted) {
      final ImagePicker picker = ImagePicker();
      // Pick an image
      final XFile? image = await picker.pickImage(source: event.imageSource);
      if (image != null) {
        CroppedFile? fotoCooper = await ImageCropper().cropImage(
          sourcePath: image.path,
          compressFormat: ImageCompressFormat.jpg,
          compressQuality: 50,
          maxHeight: 500,
          maxWidth: 500,
          uiSettings: [
            AndroidUiSettings(
                toolbarTitle: 'Editar Imagen',
                toolbarColor: Colors.deepOrange,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: false),
          ],
        );
        emit(state.copyWith(imageUrl: fotoCooper!.path));
      }
    }
  }
}
