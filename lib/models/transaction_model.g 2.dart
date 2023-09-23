// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    TransactionModel(
      id: json['_id'] as String?,
      roomId: json['roomId'] as String?,
      hostId: json['hostId'] as String?,
      transactDate: json['transactDate'] == null
          ? null
          : DateTime.parse(json['transactDate'] as String),
      status: json['status'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      rentalId: json['rentalId'] as String?,
      vehicleType: json['vehicleType'] as String?,
      startRental: json['startRental'] == null
          ? null
          : DateTime.parse(json['startRental'] as String),
      endRental: json['endRental'] == null
          ? null
          : DateTime.parse(json['endRental'] as String),
    );

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'roomId': instance.roomId,
      'hostId': instance.hostId,
      'transactDate': instance.transactDate?.toIso8601String(),
      'status': instance.status,
      'amount': instance.amount,
      'rentalId': instance.rentalId,
      'vehicleType': instance.vehicleType,
      'startRental': instance.startRental?.toIso8601String(),
      'endRental': instance.endRental?.toIso8601String(),
    };
