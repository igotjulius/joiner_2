import 'package:json_annotation/json_annotation.dart';

part 'transaction_model.g.dart';

@JsonSerializable()
class TransactionModel {
  @JsonKey(
    name: '_id',
  )
  String? id;
  String? roomId;
  String? hostId;
  DateTime? transactDate;
  String? status;
  double? amount;
  String? rentalId;
  String? vehicleType;
  DateTime? startRental;
  DateTime? endRental;

  TransactionModel({
    this.id,
    this.roomId,
    this.hostId,
    this.transactDate,
    this.status,
    this.amount,
    this.rentalId,
    this.vehicleType,
    this.startRental,
    this.endRental,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);
}
