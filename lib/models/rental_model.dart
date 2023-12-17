import 'package:json_annotation/json_annotation.dart';

part 'rental_model.g.dart';

@JsonSerializable()
class RentalModel {
  @JsonKey(
    name: '_id',
  )
  final String? id;
  final String? licensePlate;
  final String? vehicleOwner;
  final String? renterUserId;
  final String? renterName;
  final DateTime? startRental;
  final DateTime? endRental;
  final int? duration;
  final String? rentalStatus;
  final double? price;
  final String? linkedLobbyId;
  final DateTime? createdAt;
  final String? paymentId;
  final String? paymentStatus;

  const RentalModel({
    this.id,
    this.licensePlate,
    this.vehicleOwner,
    this.renterUserId,
    this.renterName,
    this.startRental,
    this.endRental,
    this.duration,
    this.rentalStatus,
    this.price,
    this.linkedLobbyId,
    this.createdAt,
    this.paymentId,
    this.paymentStatus,
  });

  factory RentalModel.fromJson(Map<String, dynamic> json) =>
      _$RentalModelFromJson(json);
  Map<String, dynamic> toJson() => _$RentalModelToJson(this);
}
