// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lobby_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LobbyModel _$LobbyModelFromJson(Map<String, dynamic> json) => LobbyModel(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      plannedDate: json['plannedDate'] as String?,
    );

Map<String, dynamic> _$LobbyModelToJson(LobbyModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'plannedDate': instance.plannedDate,
    };