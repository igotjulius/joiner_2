import 'package:json_annotation/json_annotation.dart';

part 'car_model.g.dart';

@JsonSerializable()
class CarModel {
  final String? licensePlate;
  final String? ownerName;
  final String? ownerId;
  final String? vehicleType;
  final String? availability;
  final DateTime? availableStartDate;
  final DateTime? availableEndDate;
  final double? price;
  final List<String>? photoUrl;

  const CarModel({
    this.licensePlate,
    this.ownerId,
    this.ownerName,
    this.vehicleType,
    this.availability,
    this.availableStartDate,
    this.availableEndDate,
    this.price,
    this.photoUrl,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) =>
      _$CarModelFromJson(json);
  Map<String, dynamic> toJson() => _$CarModelToJson(this);
}
