import 'package:json_annotation/json_annotation.dart';

part 'car_model.g.dart';

@JsonSerializable()
class CarModel {
  final String? licensePlate;
  final String? ownerName;
  final String? ownerId;
  final String? vehicleType;
  final double? price;
  final List<String>? photoUrl;
  final CarAvailability? availability;

  const CarModel({
    this.licensePlate,
    this.ownerId,
    this.ownerName,
    this.vehicleType,
    this.price,
    this.photoUrl,
    this.availability,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) =>
      _$CarModelFromJson(json);
  Map<String, dynamic> toJson() => _$CarModelToJson(this);
}

@JsonSerializable()
class CarAvailability {
  @JsonKey(name: '_id')
  final String? id;
  final bool? isAvailable;
  final DateTime? startDate;
  final DateTime? endDate;
  const CarAvailability({
    this.id,
    this.isAvailable,
    this.startDate,
    this.endDate,
  });
  factory CarAvailability.fromJson(Map<String, dynamic> json) =>
      _$CarAvailabilityFromJson(json);
  Map<String, dynamic> toJson() => _$CarAvailabilityToJson(this);
}
