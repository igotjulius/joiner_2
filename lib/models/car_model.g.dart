// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarModel _$CarModelFromJson(Map<String, dynamic> json) => CarModel(
      json['licensePlate'] as String?,
      json['vehicleType'] as String?,
      json['availability'] as String?,
      json['availableStartDate'] == null
          ? null
          : DateTime.parse(json['availableStartDate'] as String),
      json['availableEndDate'] == null
          ? null
          : DateTime.parse(json['availableEndDate'] as String),
      (json['price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CarModelToJson(CarModel instance) => <String, dynamic>{
      'licensePlate': instance.licensePlate,
      'vehicleType': instance.vehicleType,
      'availability': instance.availability,
      'availableStartDate': instance.availableStartDate?.toIso8601String(),
      'availableEndDate': instance.availableEndDate?.toIso8601String(),
      'price': instance.price,
    };
