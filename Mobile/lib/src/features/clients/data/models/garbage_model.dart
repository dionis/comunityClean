import '../../domain/entitie/garbage.dart';

class GarbageModel implements Garbage {
  GarbageModel(
      {required this.amountGarbage,
      required this.id,
      required this.imageUrl,
      required this.locations,
      required this.stat,
      required this.user});

  @override
  final int amountGarbage;

  @override
  final String id;

  @override
  final String imageUrl;

  @override
  final String locations;

  @override
  final bool stat;

  @override
  final String user;

  @override
  List<Object?> get props => [];

  @override
  bool get stringify => false;

  factory GarbageModel.fromJson(Map<String, dynamic> json) => GarbageModel(
        id: json["_id"] ?? '',
        user: json["user"],
        amountGarbage: json["amountGarbage"],
        stat: json["stat"] ?? false,
        imageUrl: json["image_url"],
        locations: json["locations"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "amountGarbage": amountGarbage,
        "stat": stat,
        "image_url": imageUrl,
        "locations": locations,
      };
}
