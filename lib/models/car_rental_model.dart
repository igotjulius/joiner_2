import 'package:json_annotation/json_annotation.dart';

part 'car_rental_model.g.dart';

@JsonSerializable()
class CarRentalModel {
final String? licensePlate;
final String? location;
final String? contactNo;
final String? startRental;
final String? endRental;
final int? duration;

  const CarRentalModel ({
    this.licensePlate,
    this.location,
    this.contactNo,
    this.startRental,
    this.endRental,
    this.duration,
  });

  factory CarRentalModel.fromJson(Map<String, dynamic> json) =>
      _$CarRentalModelFromJson(json);
  Map<String, dynamic> toJson() => _$CarRentalModelToJson(this);
}