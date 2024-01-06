import 'package:json_annotation/json_annotation.dart';

part 'car_model.g.dart';

@JsonSerializable()
class CarModel {
  final String? licensePlate;
  final String? ownerName;
  final String? ownerId;
  final String? location;
  final String? contactNo;
  final String vehicleType;
  final String availability;
  final DateTime startDate;
  final DateTime endDate;
  final double price;
  final List<String>? photoUrl;
  final List<Map<String, dynamic>>? schedule;

  const CarModel({
    this.licensePlate,
    this.ownerId,
    this.ownerName,
    this.location,
    this.contactNo,
    required this.vehicleType,
    required this.availability,
    required this.startDate,
    required this.endDate,
    required this.price,
    this.photoUrl,
    this.schedule,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) =>
      _$CarModelFromJson(json);
  Map<String, dynamic> toJson() => _$CarModelToJson(this);
}
