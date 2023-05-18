import 'package:equatable/equatable.dart';

abstract class Garbage extends Equatable {
  const Garbage({
    this.id,
    this.user,
    this.amountGarbage,
    this.stat,
    this.imageUrl,
    this.locations,
  });

  final String? id;
  final String? user;
  final int? amountGarbage;
  final bool? stat;
  final String? imageUrl;
  final String? locations;
}
