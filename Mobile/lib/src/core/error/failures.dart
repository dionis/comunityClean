import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]);
  @override
  List<Object?> get props => [];
}

class ConexionFailure extends Failure {}

class ImageFailure extends Failure {}
