// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
      creatorId: json['creatorId'] as String?,
      creator: json['creator'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'creatorId': instance.creatorId,
      'creator': instance.creator,
      'message': instance.message,
    };
