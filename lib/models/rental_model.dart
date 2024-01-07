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
  final String? location;
  final String? contactNo;
  final String? renterUserId;
  final String? renterName;
  final DateTime? startRental;
  final DateTime? endRental;
  final int? duration;
  final String? rentalStatus;
  final double? price;
  String? linkedLobbyId;
  final DateTime? createdAt;
  final String? paymentId;
  final String? paymentStatus;

  RentalModel({
    this.id,
    this.licensePlate,
    this.vehicleOwner,
    this.location,
    this.contactNo,
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
