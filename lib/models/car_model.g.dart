// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarModel _$CarModelFromJson(Map<String, dynamic> json) => CarModel(
      licensePlate: json['_id'] as String?,
      ownerId: json['ownerId'] as String?,
      ownerName: json['ownerName'] as String?,
      vehicleType: json['vehicleType'] as String?,
      availability: json['availability'] as String?,
      availableStartDate: json['availableStartDate'] == null
          ? null
          : DateTime.parse(json['availableStartDate'] as String),
      availableEndDate: json['availableEndDate'] == null
          ? null
          : DateTime.parse(json['availableEndDate'] as String),
      price: (json['price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CarModelToJson(CarModel instance) => <String, dynamic>{
      '_id': instance.licensePlate,
      'ownerName': instance.ownerName,
      'ownerId': instance.ownerId,
      'vehicleType': instance.vehicleType,
      'availability': instance.availability,
      'availableStartDate': instance.availableStartDate?.toIso8601String(),
      'availableEndDate': instance.availableEndDate?.toIso8601String(),
      'price': instance.price,
    };
