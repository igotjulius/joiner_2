import 'package:json_annotation/json_annotation.dart';

part 'car_model.g.dart';

@JsonSerializable()
class CarModel {
  final String? licensePlate;
  final String? ownerName;
  final String? ownerId;
  final String? vehicleType;
  final bool? isAvailable;
  final DateTime? startDate;
  final DateTime? endDate;
  final double? price;
  final List<String>? photoUrl;

  const CarModel({
    this.licensePlate,
    this.ownerId,
    this.ownerName,
    this.vehicleType,
    this.isAvailable,
    this.startDate,
    this.endDate,
    this.price,
    this.photoUrl,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) =>
      _$CarModelFromJson(json);
  Map<String, dynamic> toJson() => _$CarModelToJson(this);
}
