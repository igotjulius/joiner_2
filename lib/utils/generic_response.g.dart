// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseModel<T> _$ResponseModelFromJson<T>(Map<String, dynamic> json) =>
    ResponseModel<T>(
      code: json['code'] as int?,
      data: ResponseModel._fromJson(json['data']),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ResponseModelToJson<T>(ResponseModel<T> instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': ResponseModel._toJson(instance.data),
    };
