import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/garbage_model.dart';
import '../../domain/entitie/garbage.dart';
import '../../domain/usecases/add_garbage_request.dart';
import '../../domain/usecases/get_all_garbage_request.dart';

part 'client_event.dart';
part 'client_state.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  ClientBloc(
      {required AddGarbageRequest addGarbageRequestUse,
      required GetAllGarbageRequest getAllGarbageRequestUse})
      : _addGarbageRequestUse = addGarbageRequestUse,
        _getAllGarbageRequestUse = getAllGarbageRequestUse,
        super(ClientState.initialState()) {
    on<_ChangeDotsEvent>(_changeDotsEvent);
    on<_ChangeIndexEvent>(_changeIndexEvent);
    on<_GetAllGarbageRequest>(_getAllGarbageRequest);
    on<_AddGarbageRequest>(_addGarbageRequest);
    on<_UpdateNewGarbage>(_updateNewGarbage);
    on<_ResetNewGarbage>(_resetNewGarbage);
    on<_SubmitNewGarbage>(_submitNewGarbage);
  }
  final AddGarbageRequest _addGarbageRequestUse;
  final GetAllGarbageRequest _getAllGarbageRequestUse;

  FutureOr<void> _changeIndexEvent(
      _ChangeIndexEvent event, Emitter<ClientState> emit) {
    emit(state.copyWith(index: event.index));
  }

  FutureOr<void> _changeDotsEvent(
      _ChangeDotsEvent event, Emitter<ClientState> emit) {
    emit(state.copyWith(dotsIndex: event.dotIndex));
  }

  FutureOr<void> _getAllGarbageRequest(
      _GetAllGarbageRequest event, Emitter<ClientState> emit) async {
    emit(state.copyWith(garbageStatus: GarbageStatus.loading));
    final results = await _getAllGarbageRequestUse(id: event.id);
    results.fold(
        (error) => emit(state.copyWith(
            garbageStatus: GarbageStatus.error,
            error: 'Error de Conexion')), (garbages) {
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
    final results = await _addGarbageRequestUse(garbage: event.garbage);
    results.fold(
        (error) => emit(state.copyWith(
            error: 'Error de Conexion', garbageSubmit: GarbageSubmit.error)),
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
    value[event.key] = event.value;
    emit(state.copyWith(newGarbage: value));
    final garbage = GarbageModel.fromJson(state.newGarbage);
    state.copyWith(newGarbage: {});
    add(ClientEvent.addGarbageRequest(garbage: garbage));
  }
}
