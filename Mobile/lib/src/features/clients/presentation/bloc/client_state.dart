part of 'client_bloc.dart';

enum GarbageStatus { initial, loading, success, error }

enum GarbageSubmit { initial, loading, success, error }

class ClientState extends Equatable {
  const ClientState(
      {this.garbageStatus = GarbageStatus.initial,
      this.garbageSubmit = GarbageSubmit.initial,
      this.listCompletos = const [],
      this.listPendientes = const [],
      this.newGarbage = const {},
      this.error = '',
      this.dotsIndex = 0,
      this.index = 0,
      this.position,
      this.editGarbage});

  final GarbageStatus garbageStatus;
  final GarbageSubmit garbageSubmit;
  final List<Garbage> listCompletos;
  final List<Garbage> listPendientes;
  final int dotsIndex;
  final Map<String, dynamic> newGarbage;
  final int index;
  final String error;
  final LatLng? position;
  final GarbageModel? editGarbage;

  factory ClientState.initialState() =>
      ClientState(position: LatLng(20.02163, -75.82966));

  ClientState copyWith(
          {GarbageStatus? garbageStatus,
          List<Garbage>? listCompletos,
          List<Garbage>? listPendientes,
          GarbageSubmit? garbageSubmit,
          int? dotsIndex,
          String? error,
          Map<String, dynamic>? newGarbage,
          int? index,
          LatLng? position,
          GarbageModel? editGarbage}) =>
      ClientState(
          error: error ?? this.error,
          dotsIndex: dotsIndex ?? this.dotsIndex,
          garbageSubmit: garbageSubmit ?? this.garbageSubmit,
          newGarbage: newGarbage ?? this.newGarbage,
          listCompletos: listCompletos ?? this.listCompletos,
          listPendientes: listPendientes ?? this.listPendientes,
          garbageStatus: garbageStatus ?? this.garbageStatus,
          index: index ?? this.index,
          position: position ?? this.position,
          editGarbage: editGarbage ?? this.editGarbage);

  @override
  List<Object> get props => [
        garbageStatus,
        listCompletos,
        dotsIndex,
        index,
        error,
        newGarbage,
        garbageSubmit,
        position ?? LatLng(20.02163, -75.82966),
        editGarbage ??
            GarbageModel(
                amountGarbage: 0,
                id: '',
                imageUrl: '',
                locations: '',
                stat: false,
                user: '')
      ];
}
