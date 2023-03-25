part of 'app_bloc.dart';

abstract class AppEvent {
  factory AppEvent.changeDotsEvent({required int dots}) =>
      _ChangeDotsEvent(dotIndex: dots);

  factory AppEvent.changeIndexEvent({required int index}) =>
      _ChangeIndexEvent(index: index);
}

class _ChangeDotsEvent implements AppEvent {
  const _ChangeDotsEvent({required this.dotIndex});

  final int dotIndex;
}

class _ChangeIndexEvent implements AppEvent {
  const _ChangeIndexEvent({required this.index});
  final int index;
}
