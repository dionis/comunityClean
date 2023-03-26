part of 'client_bloc.dart';

abstract class ClientEvent {
  factory ClientEvent.changeDotsEvent({required int dots}) =>
      _ChangeDotsEvent(dotIndex: dots);

  factory ClientEvent.changeIndexEvent({required int index}) =>
      _ChangeIndexEvent(index: index);

  factory ClientEvent.getAllGarbageRequest({required String id}) =>
      _GetAllGarbageRequest(id: id);
  factory ClientEvent.addGarbageRequest({required GarbageModel garbage}) =>
      _AddGarbageRequest(garbage: garbage);

  factory ClientEvent.resetNewGarbage() => const _ResetNewGarbage();
  factory ClientEvent.submitNewGarbage(
          {required String key, required dynamic value}) =>
      _SubmitNewGarbage(value: value, key: key);

  factory ClientEvent.updateNewGarbage(
          {required String key, required dynamic value}) =>
      _UpdateNewGarbage(key: key, value: value);
}

class _ChangeDotsEvent implements ClientEvent {
  const _ChangeDotsEvent({required this.dotIndex});

  final int dotIndex;
}

class _ChangeIndexEvent implements ClientEvent {
  const _ChangeIndexEvent({required this.index});
  final int index;
}

class _GetAllGarbageRequest implements ClientEvent {
  const _GetAllGarbageRequest({required this.id});
  final String id;
}

class _AddGarbageRequest implements ClientEvent {
  const _AddGarbageRequest({required this.garbage});
  final GarbageModel garbage;
}

class _UpdateNewGarbage implements ClientEvent {
  const _UpdateNewGarbage({required this.key, required this.value});
  final String key;
  final dynamic value;
}

class _SubmitNewGarbage implements ClientEvent {
  const _SubmitNewGarbage({required this.value, required this.key});
  final String key;
  final dynamic value;
}

class _ResetNewGarbage implements ClientEvent {
  const _ResetNewGarbage();
}
