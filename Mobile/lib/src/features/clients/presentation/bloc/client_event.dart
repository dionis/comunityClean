part of 'client_bloc.dart';

abstract class ClientEvent {
  factory ClientEvent.changeDotsEvent({required int dots}) =>
      _ChangeDotsEvent(dotIndex: dots);

  factory ClientEvent.changeIndexEvent({required int index}) =>
      _ChangeIndexEvent(index: index);

  factory ClientEvent.getAllGarbageRequest({required String id}) =>
      _GetAllGarbageRequest(id: id);
  factory ClientEvent.addGarbageRequest(
          {required GarbageModel garbage, required int id}) =>
      _AddGarbageRequest(garbage: garbage, id: id);

  factory ClientEvent.resetNewGarbage() => const _ResetNewGarbage();
  factory ClientEvent.submitNewGarbage(
          {required String key, required dynamic value}) =>
      _SubmitNewGarbage(value: value, key: key);

  factory ClientEvent.updateNewGarbage(
          {required String key, required dynamic value}) =>
      _UpdateNewGarbage(key: key, value: value);
  factory ClientEvent.deleteGarbageRequest({required String id}) =>
      _DeleteGarbage(id: id);
  factory ClientEvent.updatePosition({required LatLng newPosition}) =>
      _UpdatePosition(newPosition: newPosition);
  factory ClientEvent.updateGarbage({required GarbageModel? newGarbage}) =>
      _UpdateGarbage(newGarbage: newGarbage);
  factory ClientEvent.updateRequest({required GarbageModel newGarbage}) =>
      _UpdateRequest(newGarbage: newGarbage);

  factory ClientEvent.updateImageUrl({required ImageSource imageSource}) =>
      _UpdateImageUrl(imageSource: imageSource);
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
  const _AddGarbageRequest({required this.garbage, required this.id});
  final GarbageModel garbage;
  final int id;
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

class _DeleteGarbage implements ClientEvent {
  const _DeleteGarbage({required this.id});
  final String id;
}

class _UpdatePosition implements ClientEvent {
  _UpdatePosition({required this.newPosition});
  final LatLng newPosition;
}

class _UpdateGarbage implements ClientEvent {
  _UpdateGarbage({required this.newGarbage});
  final GarbageModel? newGarbage;
}

class _UpdateRequest implements ClientEvent {
  _UpdateRequest({required this.newGarbage});
  final GarbageModel newGarbage;
}

class _UpdateImageUrl implements ClientEvent {
  _UpdateImageUrl({required this.imageSource});
  final ImageSource imageSource;
}
