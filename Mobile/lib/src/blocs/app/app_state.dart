part of 'app_bloc.dart';

class AppState extends Equatable {
  const AppState({this.dotsIndex = 0, this.index = 0});
  final int dotsIndex;
  final int index;

  factory AppState.intialState() => const AppState();

  AppState copyWith({int? dotsIndex, int? index}) => AppState(
      dotsIndex: dotsIndex ?? this.dotsIndex, index: index ?? this.index);

  @override
  List<Object> get props => [dotsIndex, index];
}
