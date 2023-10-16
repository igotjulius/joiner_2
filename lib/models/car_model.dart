import 'package:json_annotation/json_annotation.dart';

part 'car_model.g.dart';

@JsonSerializable()
class CarModel {
  @JsonKey(
    name: '_id',
  )
  final String? licensePlate;
  final String? ownerName;
  final String? ownerId;
  final String? vehicleType;
  final String? availability;
  final DateTime? availableStartDate;
  final DateTime? availableEndDate;
  final double? price;

  const CarModel({
    this.licensePlate,
    this.ownerId,
    this.ownerName,
    this.vehicleType,
    this.availability,
    this.availableStartDate,
    this.availableEndDate,
    this.price,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) =>
      _$CarModelFromJson(json);
  Map<String, dynamic> toJson() => _$CarModelToJson(this);
}
