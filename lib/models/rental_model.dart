import 'package:json_annotation/json_annotation.dart';

part 'rental_model.g.dart';

@JsonSerializable()
class RentalModel {
  @JsonKey(
    name: '_id',
    includeFromJson: true,
    includeToJson: false,
  )
  final String? id;
  final String? vehicleOwner;
  final String? renterUserId;
  final String? renterName;
  final DateTime? startRental;
  final DateTime? endRental;
  final int? duration;
  final String? rentalStatus;
  final double? price;
  final String? paymentId;
  final String? paymentStatus;
  final DateTime? createdAt;

  const RentalModel({
    this.id,
    this.vehicleOwner,
    this.renterUserId,
    this.renterName,
    this.startRental,
    this.endRental,
    this.duration,
    this.rentalStatus,
    this.price,
    this.paymentId,
    this.paymentStatus,
    this.createdAt,
  });

  factory RentalModel.fromJson(Map<String, dynamic> json) =>
      _$RentalModelFromJson(json);
  Map<String, dynamic> toJson() => _$RentalModelToJson(this);
}
