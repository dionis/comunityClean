import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppState.intialState()) {
    on<_ChangeDotsEvent>(_changeDotsEvent);
    on<_ChangeIndexEvent>(_changeIndexEvent);
  }

  FutureOr<void> _changeDotsEvent(
      _ChangeDotsEvent event, Emitter<AppState> emit) async {
    emit(state.copyWith(dotsIndex: event.dotIndex));
  }

  FutureOr<void> _changeIndexEvent(
      _ChangeIndexEvent event, Emitter<AppState> emit) {
    emit(state.copyWith(index: event.index));
  }
}
